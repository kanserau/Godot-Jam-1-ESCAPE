extends Node3D
class_name ConsolePowerSwitch

@export var screens: Array[MeshInstance3D] = []

func toggle(on: bool):
	for s in screens:
		s.visible = on
