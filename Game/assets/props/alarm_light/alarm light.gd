extends Node3D
class_name EmergencyLight

func _ready():
	toggle(false)

func toggle(on: bool):
	if on:
		%glow.visible = true
		%beam1.visible = true
		%beam2.visible = true
		$Sketchfab_model/AnimationPlayer.play("spin")
	else:
		%glow.visible = false
		%beam1.visible = false
		%beam2.visible = false
		$Sketchfab_model/AnimationPlayer.play("off")
