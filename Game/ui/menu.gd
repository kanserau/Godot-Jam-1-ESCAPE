extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	SceneManager.change_scene_and_delete("res://main.tscn")



func _on_quit_pressed():
	get_tree().quit()