extends Node3D

@export var lights: Array[Light3D] = []
@export var emergency_lights: Array[EmergencyLight] = []
var power_button: PowerButton

# Called when the node enters the scene tree for the first time.
func _ready():
	power_button = get_node("%power button")
	power_button.power_restored.connect(_on_power_restored)
	GameManager.connect_to_signal("event_triggered", self, "_on_event_triggered")
	
		# TODO: REMOVE
	var event = GameEvent.new()
	event.event = GameEvent.GameTypes.Events.POWER_GENERATOR
	event.weight = 1
	GameManager.emit_signal("event_triggered", event)


func _on_event_triggered(event: GameEvent):
	if event.event != GameEvent.GameTypes.Events.POWER_GENERATOR:
		return
	power_button.power_failure_triggered(event)
	for l in emergency_lights:
		l.toggle(true)
	for l in lights:
		l.visible = false

func _on_power_restored():
	for l in emergency_lights:
		l.toggle(false)
	for l in lights:
		l.visible = true
	
