extends Control
class_name Power_UI

@onready var engine_icon: Button = get_node('%Engine/Engine')
@onready var o2_icon: Button = get_node('%O2/O2')
@onready var shields_icon: Button = get_node('%Shields/Shields')
@onready var weapons_icon: Button = get_node('%Weapons/Weapons')
@onready var power_icon: Button = get_node('%Power/Button')
var event_mapping: Dictionary = {}

@onready var engine_display: TextureProgressBar = get_node('%Engine/TextureProgressBar')
@onready var o2_display: TextureProgressBar = get_node('%O2/TextureProgressBar')
@onready var shields_display: TextureProgressBar = get_node('%Shields/TextureProgressBar')
@onready var weapons_display: TextureProgressBar = get_node('%Weapons/TextureProgressBar')
@onready var power_display: TextureProgressBar = get_node('%Power/TextureProgressBar')


# Called when the node enters the scene tree for the first time.
func _ready():
	event_mapping = {
		GameTypes.Events.ENGINE: engine_icon,
		GameTypes.Events.ATMOSPHERE_GENERATOR: o2_icon,
		GameTypes.Events.SHIELDS: shields_icon,
		GameTypes.Events.WEAPONS: weapons_icon
	}
	GameManager.event_triggered.connect(_on_event_triggered)
	update_ui()

func _on_event_triggered(_event: GameEvent):
	update_ui()

func available_power():
	return (
		GameManager.stats.total_starting_power
		- GameManager.stats.current_atmosphere_generator
		- GameManager.stats.current_thrust
		- GameManager.stats.current_weapons
		- GameManager.stats.current_shields
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_ui():
	var active_events = GameManager.active_events.map(func(event): return event.event)
	for event_name in event_mapping:
		var icon: Button = event_mapping[event_name]
		if active_events.has(event_name):
			icon.modulate = "#ff0000"
			icon.disabled = true
		else:
			icon.modulate = "#00ff00"
			icon.disabled = false
	
	engine_display.value = GameManager.stats.current_thrust
	o2_display.value = GameManager.stats.current_atmosphere_generator
	shields_display.value = GameManager.stats.current_shields
	weapons_display.value = GameManager.stats.current_weapons
	power_display.value = available_power()

func has_active_event(event_type):
	return GameManager.active_events.any(func(c): return c.event == event_type)

func adjust_system_power(gui_event, system, current, step, maximum):
	if has_active_event(system):
		return current
	if not (gui_event is InputEventMouseButton and gui_event.pressed):
		return current
	var available = available_power()
	match gui_event.button_index:
		MOUSE_BUTTON_LEFT:
			if available >= step and current < maximum:
				return current + step
		MOUSE_BUTTON_RIGHT:
			if current >= step:
				return current - step
	return current

func _on_weapons_gui_input(event):
	GameManager.stats.current_weapons = adjust_system_power(
		event, GameTypes.Events.WEAPONS,
		GameManager.stats.current_weapons, 2, 2
	)
	update_ui()

func _on_shields_gui_input(event):
	GameManager.stats.current_shields = adjust_system_power(
		event, GameTypes.Events.SHIELDS,
		GameManager.stats.current_shields, 2, 2
	)
	update_ui()


func _on_o2_gui_input(event):
	GameManager.stats.current_atmosphere_generator = adjust_system_power(
		event, GameTypes.Events.ATMOSPHERE_GENERATOR,
		GameManager.stats.current_atmosphere_generator, 1, 2
	)
	update_ui()


func _on_engine_gui_input(event):
	GameManager.stats.current_thrust = adjust_system_power(
		event, GameTypes.Events.ENGINE,
		GameManager.stats.current_thrust, 1, 3
	)
	update_ui()
