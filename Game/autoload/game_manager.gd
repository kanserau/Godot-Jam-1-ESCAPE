extends Node

class_name GameSignalManager


var stats: GameResource
var crew_members: Array[Crew] = []
var dead_crew_members: Array[Crew] = []
var events: Array[GameEvent] = []
var active_events: Array[GameEvent] 
var terminal_history: Array[Node] = []
var active_event_locations: Dictionary = {}
var solar_flare_incoming = false
var debris_incoming = false
var ui_active = false
var intro_finished = false

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

signal update_everything

signal terminal_history_updated()
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
	warn_solar_flare.connect(toggle_solar_flare_min)
	warn_debris.connect(toggle_debris_min)
	solar_flare_hit.connect(toggle_solar_flare)
	space_debris_hit.connect(toggle_debris)
	event_triggered.connect(handle_failures)


##
# Utilities
## 

func load_event_resources():
	for event in DynamicLoader.load_from("res://resources/events"):
		events.append(event)

func load_crew_resources():
	for crew in DynamicLoader.load_from("res://resources/crew/"):
		crew_members.append(crew)

func connect_to_signal(signal_name: String, target_node: Node, method_name: String):
	if has_signal(signal_name) and target_node.has_method(method_name):
		connect(signal_name, Callable(target_node, method_name))
	else:
		printerr("Error: Signal '%s' or method '%s' does not exist." % [signal_name, method_name])

func toggle_solar_flare_min(min_left):
	solar_flare_incoming = !solar_flare_incoming

func toggle_debris_min(min_left):
	debris_incoming = !debris_incoming

func toggle_solar_flare():
	solar_flare_incoming = !solar_flare_incoming
	update_everything.emit()

func toggle_debris():
	debris_incoming = !debris_incoming
	update_everything.emit()

func handle_failures(event: GameEvent):
	if event.event == GameTypes.Events.ENGINE:
		stats.current_thrust = 0
	elif event.event == GameTypes.Events.ATMOSPHERE_GENERATOR:
		stats.current_atmosphere_generator = 0
	elif event.event == GameTypes.Events.SHIELDS:
		stats.current_shields = 0
	elif event.event == GameTypes.Events.WEAPONS:
		stats.current_weapons = 0
