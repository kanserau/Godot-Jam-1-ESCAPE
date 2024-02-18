extends Node3D

signal fix();
@export var target: Node3D = null

func _ready():
	fix.connect(_on_fix)

func _on_fix():
	if not target:
		return
	target.emit_signal("fix")
