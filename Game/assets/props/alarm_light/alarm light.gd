extends Node3D
class_name EmergencyLight

# TODO:
# @export var color -> on set override Geam

func _ready():
	toggle(false)

func toggle(on: bool):
	if on:
		get_node("%glow").visible = true
		get_node("%beam1").visible = true
		get_node("%beam2").visible = true
		$Sketchfab_model/AnimationPlayer.play("spin")
	else:
		get_node("%glow").visible = false
		get_node("%beam1").visible = false
		get_node("%beam2").visible = false
		$Sketchfab_model/AnimationPlayer.play("off")
