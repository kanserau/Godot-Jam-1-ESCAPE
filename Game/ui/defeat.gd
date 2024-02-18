extends Control

@onready var stats = $Statistics

func _ready():
	stats.text = """
	
	-------------------
	Final Statistics
	-------------------

	Ship distance: %s/%s
	Ship damage: %s/%s\n\n""" % [
		GameManager.stats.distance,
		GameManager.stats.target_distance,
		GameManager.stats.ship_damage,
		GameManager.stats.max_ship_damage,
	]
	
	stats.text += "\n Alive crew members: \n"
	
	for crew in GameManager.crew_members:
		stats.text += crew.name + " "
	
	stats.text += "\n Dead crew members: \n"
	
	for crew in GameManager.dead_crew_members:
		stats.text += crew.name + " "
