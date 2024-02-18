extends Node3D

@export var lights: Array[Light3D] = []
@export var emergency_lights: Array[EmergencyLight] = []
var power_button: PowerButton
var console: ConsolePowerSwitch

# Called when the node enters the scene tree for the first time.
func _ready():
	power_button = get_node("%power button")
	console = get_node("%desk console")
	power_button.power_restored.connect(_on_power_restored)
	GameManager.connect_to_signal("event_triggered", self, "_on_event_triggered")

func _on_event_triggered(event: GameEvent):
	if event.event != GameEvent.GameTypes.Events.POWER_GENERATOR:
		return
	power_button.power_failure_triggered(event)
	for l in emergency_lights:
		l.toggle(true)
	console.toggle(false)
	for l in lights:
		l.visible = false

func _on_power_restored():
	for l in emergency_lights:
		l.toggle(false)
	console.toggle(true)
	for l in lights:
		l.visible = true
	