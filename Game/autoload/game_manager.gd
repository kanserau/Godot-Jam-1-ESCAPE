extends Node

class_name GameSignalManager

var stats: GameResource
var crew_members: Array[Crew] = []
var events: Array[GameEvent] = []
var active_events: Array[GameEvent] 

signal change_ship_damage(total_ship_damage)
signal crew_members_damaged
signal event_triggered(event: GameEvent)
signal ship_moved(total_distance)

# Unused
signal change_available_power(new_value)
signal change_thrust(new_value)
signal change_weapons(new_value)
signal change_atmosphere_generator(new_value)
signal change_shields(new_value)

signal create_hull_breach
signal warn_solar_flare(minutes)
signal start_solar_flare


func _ready():
	stats = preload("res://resources/game.tres")
	load_event_resources()
	load_crew_resources()


##
# Utilities
## 
func load_event_resources():
	var dir = DirAccess.open("res://resources/events")
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource = load("res://resources/events/" + file_name)
				events.append(resource)
			file_name = dir.get_next()

func load_crew_resources():
	var dir = DirAccess.open("res://resources/crew")
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource = load("res://resources/crew/" + file_name)
				crew_members.append(resource)
			file_name = dir.get_next()

func connect_to_signal(signal_name: String, target_node: Node, method_name: String):
	if has_signal(signal_name) and target_node.has_method(method_name):
		connect(signal_name, Callable(target_node, method_name))
	else:
		printerr("Error: Signal '%s' or method '%s' does not exist." % [signal_name, method_name])

func _process(_delta):
	pass
