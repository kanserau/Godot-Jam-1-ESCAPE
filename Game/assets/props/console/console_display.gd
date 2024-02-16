extends Node3D

signal display_toggled(on)
@export var display = true:
	get:
		return display
	set(value):
		display_toggled.emit(value) 
		display = value

@export var display_meshes: Array[MeshInstance3D] = []
@export var display_off_material: BaseMaterial3D = preload("res://assets/props/console/blue_screen_of_death.tres")

func _on_display_toggled(on: bool):
	if display_meshes.is_empty():
		return
	for mesh in display_meshes:
		if on:
			mesh.set_surface_override_material(0, null)
		else:
			mesh.set_surface_override_material(0, display_off_material)

func _ready():
	display_toggled.connect(_on_display_toggled)
	_on_display_toggled(display)
