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
		GameEvent.GameTypes.Events.ENGINE: engine_icon,
		GameEvent.GameTypes.Events.ATMOSPHERE_GENERATOR: o2_icon,
		GameEvent.GameTypes.Events.SHIELDS: shields_icon, 
		GameEvent.GameTypes.Events.WEAPONS: weapons_icon
	}
	GameManager.connect_to_signal("event_triggered", self, "_on_event_triggered")
	update_ui()

func _on_event_triggered():
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
		else:
			icon.modulate = "#00ff00"
	
	engine_display.value = GameManager.stats.current_thrust
	o2_display.value = GameManager.stats.current_atmosphere_generator
	shields_display.value = GameManager.stats.current_shields
	weapons_display.value = GameManager.stats.current_weapons
	power_display.value = available_power()
