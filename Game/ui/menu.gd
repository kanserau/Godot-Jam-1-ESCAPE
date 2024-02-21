extends Control

func _on_start_pressed():
	SceneManager.change_scene_and_delete("res://main.tscn")

func _on_quit_pressed():
	get_tree().quit()
