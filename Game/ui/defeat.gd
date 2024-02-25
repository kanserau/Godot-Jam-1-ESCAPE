extends Control

@onready var stats = $Statistics

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	stats.text = """
	
	-------------------
	Final Statistics
	-------------------

	Ship distance: %s%%
	Ship integrity: %s%%\n\n""" % [
		GameManager.stats.distance_percent(),
		GameManager.stats.ship_integrity_percent(),
	]
	
	stats.text += "\n Alive crew members: \n"
	
	for crew in GameManager.crew_members:
		stats.text += crew.name + "\n"
	
	stats.text += "\n Dead crew members: \n"
	
	for crew in GameManager.dead_crew_members:
		stats.text += crew.name + "\n"


func _on_retry_pressed():
	GameManager.retry()
	SceneManager.remove_overlay()
	SceneManager.change_scene_and_delete("res://main.tscn")
