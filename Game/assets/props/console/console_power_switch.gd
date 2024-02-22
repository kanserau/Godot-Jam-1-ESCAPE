extends Node3D
class_name ConsolePowerSwitch

signal fix();

@export var screens: Array[MeshInstance3D] = []
@onready var collider: CollisionShape3D = $console/terminal_trigger/CollisionShape3D
@onready var camera: Camera3D = $Camera3D

func _ready():
	fix.connect(_on_fix)

func toggle(on: bool):
	for s in screens:
		s.visible = on
	collider.disabled = !on

func _on_fix():
	SceneManager.add_overlay("res://ui/console/console.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
