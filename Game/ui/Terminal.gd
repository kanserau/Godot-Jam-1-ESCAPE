extends Control

const GameTypes = preload("res://resources/templates/types.gd")

@onready var input = $MarginContainer/VBoxContainer/InputArea/HBoxContainer/Input
@onready var history_rows = $MarginContainer/VBoxContainer/GameInfo/Scroll/HistoryRows
@onready var scroll = $MarginContainer/VBoxContainer/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()


const InputResponse = preload("res://ui/InputResponse.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	input.grab_focus()
	scrollbar.connect("changed", Callable(self, "handle_scrollbar_changed"))
	var input_response = InputResponse.instantiate()
	input_response.initial(handle_text_response("info"))
	history_rows.add_child(input_response)
	
func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value
	
func _unhandled_input(event):
	get_viewport().set_input_as_handled()
	if event.is_action_pressed("escape") and not event.is_echo():
		SceneManager.remove_overlay()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event.is_action_pressed("escape"):
		if input.has_focus():
			get_viewport().set_input_as_handled()
			SceneManager.remove_overlay()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			get_viewport().set_input_as_handled()
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
		"shunt":
			response = handle_shunt(instructions)
		"defib":
			response = handle_defib(instructions)
		"supress":
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
- shunt [target] [target power] - Sets something to a certain power level
- defib [crew member id]: Attempts to revive a crew member at critical condition.
- resolve [event name]: Tries to fix systems that reduce ship capabalities. Need to shunt power again.
- suppress [location]: Attempts to extinguish all fire at the specified location.
- repair [location]: Attempts to seal all hull breaches at the specified location."""

func get_info() -> String:
	var total_power = GameManager.stats.total_starting_power - GameManager.stats.current_atmosphere_generator - GameManager.stats.current_thrust - GameManager.stats.current_weapons - GameManager.stats.current_shields
	var game_info = """Systems controlled by shunt:
	-------------------

	Current available power: %s
	
	Current atmospheric: %s/%s
	Current thrust: %s/%s
	Current shields: %s/%s
	Current weapons: %s/%s

	Extra:
	-------

	Ship distance: %s/%s
	Ship damage: %s/%s
	Current oxygen controlled by atmospheric generator level: %s L:%s M:%s H:%s

	Number of active emergencies: %s
	Number of location based emergencies: %s""" % [
		total_power, 
		GameManager.stats.current_atmosphere_generator,
		2,
		GameManager.stats.current_thrust, 
		3,
		GameManager.stats.current_shields, 
		GameManager.stats.shields_on,
		GameManager.stats.current_weapons,
		GameManager.stats.weapons_on,
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

func handle_shunt(instructions: String) -> String:
	var instructions_arr = instructions.split(" ")
	var possible = ["thrust", "atmospheric", "shields", "weapons"]
	if instructions_arr.size() != 2 or instructions_arr[0].to_lower() not in possible:
		return "Invalid command. Please use the format: shunt [system] [value]"
	
	var system = instructions_arr[0].to_lower()
	var value_str = instructions_arr[1]

	var value = 0
	if value_str.is_valid_int():
		value = int(value_str)
	else:
		return "System value must be a valid integer."
	
	var total_power = GameManager.stats.total_starting_power
	var used_power = GameManager.stats.current_thrust + GameManager.stats.current_atmosphere_generator + GameManager.stats.current_shields + GameManager.stats.current_weapons
	var available_power = total_power - used_power
	
	if system == "thrust":
		if value < 0 or value > 3:
			return "Invalid value for thrust. Please enter a value between 0 and 3" + "."
		elif value - GameManager.stats.current_thrust > available_power:
			return "Not enough power available to set thrust to " + str(value) + "."
		else:
			if GameManager.active_events.any(func(c): return c.event == GameTypes.Events.ENGINE):
				return "Please resolve engine failure to shunt power"
			GameManager.stats.current_thrust = value
	elif system == "atmospheric":
		if value < 0 or value > 2:
			return "Invalid value for atmospheric generator. Please enter a value between 0 and 2."
		elif value - GameManager.stats.current_atmosphere_generator > available_power:
			return "Not enough power available to set atmospheric generator to " + str(value) + "."
		else:
			if GameManager.active_events.any(func(c): return c.event == GameTypes.Events.ATMOSPHERE_GENERATOR):
				return "Please resolve atmospheric generator failure to shunt power"
			GameManager.stats.current_atmosphere_generator = value
	elif system == "shields":
		if value < 0 or value > GameManager.stats.shields_on:
			return "Invalid value for shields. Please enter a value between 0 and " + str(GameManager.stats.shields_on) + "."
		elif value - GameManager.stats.current_shields > available_power:
			return "Not enough power available to set shields to " + str(value) + "."
		else:
			if GameManager.active_events.any(func(c): return c.event == GameTypes.Events.SHIELDS):
				return "Please resolve shields failure to shunt power"
			GameManager.stats.current_shields = value
	elif system == "weapons":
		if value < 0 or value > GameManager.stats.weapons_on:
			return "Invalid value for weapon. Please enter a value between 0 and " + str(GameManager.stats.weapons_on) + "."
		elif value - GameManager.stats.current_weapons > available_power:
			return "Not enough power available to set weapons to " + str(value) + "."
		else:
			if GameManager.active_events.any(func(c): return c.event == GameTypes.Events.WEAPONS):
				return "Please resolve weapons failure to shunt power"
			GameManager.stats.current_weapons = value
	
	return "System " + system + " set to " + str(value) + "."

func handle_defib(instructions: String) -> String:
	if instructions.is_empty():
		return "Usage: defib [crew member id]"
	var crew_id = instructions
	for crew_member in GameManager.crew:
		if crew_member.id == crew_id and crew_member.status == GameTypes.CrewStatus.CRITICAL:
			crew_member.health += GameManager.stats.crew_defib_regeneration
			return "Defibrillation successful on crew member: " + crew_member.name
	return "Crew member ID not found."

func handle_extinguish(instructions: String) -> String:
	if instructions.is_empty() or instructions.replace(" ", "_").to_upper() not in GameTypes.Locations.keys():
		return "Usage: extinguish [location]"
	var found = false
	for key in GameManager.active_event_locations.keys():
		var location = GameManager.active_event_locations[key]
		if key.event == GameTypes.Events.FIRE && GameTypes.Locations.keys()[location] == instructions.to_upper().replace(" ", "_"):
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

	if instructions.is_empty() or event_name not in keys:
		return "Usage: resolve [event name]"
	for i in range(GameManager.active_events.size()):
		if GameManager.active_events[i].event == GameTypes.Events[event_name]:
			GameManager.active_events.erase(GameManager.active_events[i])
			GameManager.emit_signal("update_everything")
			return "Event " + instructions + " resolved."
	return "Event not found or cannot be resolved."


func handle_seal(instructions: String) -> String:
	if instructions.is_empty() or instructions.to_upper().replace(" ", "_") not in GameTypes.Locations.keys():
		return "Usage: suppress [location]"
	var found = false
	for key in GameManager.active_event_locations.keys():
		var location = GameManager.active_event_locations[key]
		if key.event == GameTypes.Events.HULLBREACH && GameTypes.Locations.keys()[location] == instructions.to_upper().replace(" ", "_"):
			GameManager.active_events.erase(key)
			GameManager.active_event_locations.erase(key)
			found = true
	if found:
		return "Repaired breaches at " + instructions
	else:
		return "No breaches to repair"



func create_response_label(text: String) -> Control:
	var input_response = InputResponse.instantiate()
	input_response.set_text(text)
	return input_response
	

func _on_input_text_submitted(new_text):
	var input_response = InputResponse.instantiate()
	input_response.set_text(new_text, handle_text_response(new_text))
	history_rows.add_child(input_response)
	input.clear()
