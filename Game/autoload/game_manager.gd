extends Node

class_name GameSignalManager

const GameTypes = preload("res://resources/templates/types.gd")

var stats: GameResource
var crew_members: Array[Crew] = []
var dead_crew_members: Array[Crew] = []
var events: Array[GameEvent] = []
var active_events: Array[GameEvent] 
var active_event_locations = {}

signal change_ship_damage(total_ship_damage)
signal crew_members_damaged
signal event_triggered(event: GameEvent)
signal ship_moved(total_distance)

signal warn_solar_flare(minutes)
signal warn_debris(minutes)

signal solar_flare_hit
signal space_debris_hit
signal weapons_firing

signal change_oxygen(current_units)

# Unused
signal change_available_power(new_value)
signal change_thrust(new_value)
signal change_weapons(new_value)
signal change_atmosphere_generator(new_value)
signal change_shields(new_value)


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
