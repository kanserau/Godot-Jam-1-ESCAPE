extends Node3D
class_name Console

signal fix();

@export var screens: Array[MeshInstance3D] = []
@onready var collider: CollisionShape3D = $console/terminal_trigger/CollisionShape3D
@onready var camera: Camera3D = $Camera3D
@onready var sparks: GPUParticles3D = $GPUParticles3D
@onready var glitch_sfx: AudioStreamPlayer3D = $GPUParticles3D/AudioStreamPlayer3D
var captured_event: Array[GameEvent] = []

func _ready():
	sparks.emitting = false
	GameManager.event_triggered.connect(_on_event_triggered)
	fix.connect(_on_fix)

func _on_event_triggered(event: GameEvent):
	if event.event != GameTypes.Events.TERMINAL:
		return
	captured_event.append(event)
	sparks.emitting = true
	glitch_sfx.play()
	SceneManager.remove_overlay()

func toggle(on: bool):
	for s in screens:
		s.visible = on
	collider.disabled = !on

func _on_fix():
	if not captured_event.is_empty():
		while not captured_event.is_empty():
			GameManager.active_events.erase(captured_event.pop_back())
		sparks.emitting = false
		glitch_sfx.stop()
	else:
		SceneManager.add_overlay("res://ui/console/console.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
