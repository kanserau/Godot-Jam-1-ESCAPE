extends Control

const InputResponse = preload("res://ui/InputResponse.tscn")

@onready var input = $MarginContainer/VBoxContainer/InputArea/HBoxContainer/Input
@onready var history_rows = $MarginContainer/VBoxContainer/GameInfo/Scroll/HistoryRows
@onready var scroll = $MarginContainer/VBoxContainer/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


# Called when the node enters the scene tree for the first time.
func _ready():
	scrollbar.connect("changed", Callable(self, "handle_scrollbar_changed"))
	var input_response = InputResponse.instantiate()
	input_response.initial(handle_text_response("help"))
	input_response.initial(handle_text_response("info"))
	history_rows.add_child(input_response)
	
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value
	
func _unhandled_input(event):
	get_viewport().set_input_as_handled()
	if event.is_action_pressed("escape") and not event.is_echo():
		SceneManager.remove_overlay()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func handle_text_response(text) -> String:
	var command = text.split(" ", true, 1)[0].to_lower().strip_edges()
	var instructions = ""
	if " " in text:
		instructions = text.split(" ", true, 1)[1].to_lower().strip_edges()
	var response = ""
	match command:
		"help":
			response = get_help()
		"info":
			response = get_info()
		"locations":
			response = get_locations()
		"resolve":
			response = get_resolve(instructions)
		"crew":
			response = get_crew()
		"events":
			response = get_resolvable_events()
		"defib":
			response = handle_defib(instructions)
		"suppress":
			response = handle_extinguish(instructions)
		"repair":
			response = handle_seal(instructions)
		_:
			response = "Unknown command: " + command
	return response

func get_locations() -> String:
	var locations_list = []
	for key in GameTypes.Locations.keys():
		locations_list.append(key.to_lower().replace("_", " "))
	return "\n".join(locations_list)

func get_resolvable_events() -> String:
	var events_list = []
	var keys = GameTypes.Events.keys()
	keys.erase("HULLBREACH")
	keys.erase("FIRE")
	for key in keys:
		events_list.append(key.to_lower().replace("_", " "))
	return "\n".join(events_list)

func get_crew() -> String:
	var crew_details = "Crew Members:\n"
	for member in GameManager.crew_members:
		crew_details += "ID: %s, Name: %s, Role: %s, Location: %s, Status: %s, Health: %d\n" % [
			member.id,
			member.name,
			member.role,
			GameTypes.Locations.keys()[member.location].replace("_", " "),
			GameTypes.CrewStatus.keys()[member.status].replace("_", " "),
			member.health
		]
	crew_details += "\nDeceased Crew Members:\n"
	for member in GameManager.dead_crew_members:
		crew_details += "ID:%s, Name: %s, Role: %s, Location: %s, Status: Deceased, Health: %d\n" % [
			member.id,
			member.name,
			member.role,
			GameTypes.Locations.keys()[member.location].replace("_"," "),
			member.health
		]
	return crew_details

func get_help() -> String:

	return """Available commands: 

Game info: Manage your spaceship and crew to survive. Navigate through space, handle emergencies, and ensure the survival of your crew!

Look at event feed to know location of fires and hull breaches.
Locations are case insensitive.

ENGINE affects thrust.
ATMOSPERIC GENERATOR affects oxygen levels.
SHIELDS affects shield levels.
WEAPONS affect weapon levels.

- help: Displays this help message.
- info: Shows ship information.
- locations: Shows general game locations for fire and breach handling.
- crew: Shows crew welfare
- events: Shows resolvable events
- defib [crew member id]: Attempts to revive a crew member at critical condition.
- resolve [event name]: Tries to fix systems that reduce ship capabalities. Need to shunt power again.
- suppress [location]: Attempts to extinguish all fire at the specified location.
- repair [location]: Attempts to seal all hull breaches at the specified location."""

func get_info() -> String:
	var total_power = GameManager.stats.total_starting_power - GameManager.stats.current_atmosphere_generator - GameManager.stats.current_thrust - GameManager.stats.current_weapons - GameManager.stats.current_shields
	var game_info = """
	Ship distance: %s/%s
	Ship damage: %s/%s
	Current oxygen controlled by atmospheric generator level: %s L:%s M:%s H:%s

	Number of active emergencies: %s
	Number of location based emergencies: %s""" % [
		GameManager.stats.distance,
		GameManager.stats.target_distance,
		GameManager.stats.ship_damage,
		GameManager.stats.max_ship_damage,
		GameManager.stats.current_oxygen,
		GameManager.stats.low_oxygen,
		GameManager.stats.medium_oxygen,
		GameManager.stats.high_oxygen,
		GameManager.active_events.size(),
		GameManager.active_event_locations.values().size()
	]
	return game_info

func handle_defib(instructions: String) -> String:
	if instructions.is_empty():
		return "Usage: defib [crew member id]"
	var crew_id = instructions
	for crew_member in GameManager.crew_members:
		if crew_member.id == crew_id and crew_member.status == GameTypes.CrewStatus.CRITICAL:
			crew_member.health += GameManager.stats.crew_defib_regeneration
			return "Defibrillation successful on crew member: " + crew_member.name
	return "Crew member ID not found."

func handle_extinguish(instructions: String) -> String:
	var location_name = instructions.replace(" ", "_").to_upper()
	var keys = GameTypes.Locations.keys()
	keys.erase("ENGINE_ROOM")
	if location_name.to_upper() not in keys:
		return "Usage: suppress [location]"
	var found = false
	for key in GameManager.active_event_locations.keys():
		var location = GameManager.active_event_locations[key]
		if key.event == GameTypes.Events.FIRE && location == location_name:
			GameManager.active_events.erase(key)
			GameManager.active_event_locations.erase(key)
			found = true
	if found:
		return "Extinguished flames at " + instructions
	else:
		return "No flames to extinguish"

func get_resolve(instructions: String) -> String:
	var keys = GameTypes.Events.keys()
	var event_name = instructions.to_upper().replace(" ", "_")

	keys.erase("HULLBREACH")
	keys.erase("FIRE")
	keys.erase("ATMOSPHERE_GENERATOR")

	if instructions.is_empty() or event_name not in keys:
		return "Usage: resolve [event name]"
	for i in range(GameManager.active_events.size()):
		if GameManager.active_events[i].event == GameTypes.Events[event_name]:
			GameManager.active_events.erase(GameManager.active_events[i])
			GameManager.update_everything.emit()
			return "Event " + instructions + " resolved."
	return "Event not found or cannot be resolved."

func handle_seal(instructions: String) -> String:
	if instructions.is_empty() or instructions.to_upper().replace(" ", "_") not in GameTypes.Locations.keys():
		return "Usage: repair [location]"
	var found = false
	for key in GameManager.active_event_locations.keys():
		var location = GameManager.active_event_locations[key]
		if key.event == GameTypes.Events.HULLBREACH && location == instructions.to_upper().replace(" ", "_"):
			GameManager.active_events.erase(key)
			GameManager.active_event_locations.erase(key)
			found = true
	if found:
		return "Repaired breaches at " + instructions
	else:
		return "No breaches to repair"

# unused code (broken)
#func create_response_label(text: String) -> Control:
	#var input_response = InputResponse.instantiate()
	#input_response.set_text(text)
	#return input_response
	#

func _on_input_text_submitted(new_text: String):
	var command = new_text.strip_edges()
	var input_response = InputResponse.instantiate()
	var response = handle_text_response(command)
	input_response.set_text(command, response)
	input_response.set_error(response.begins_with("Unknown command"))
	history_rows.add_child(input_response)
	input.clear()
