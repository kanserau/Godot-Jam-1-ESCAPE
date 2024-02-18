extends Node

var game_time = 0.0
var accumulated_time = 0.0
var emergencies_triggered = false
var debris_triggered = true 
var solar_flare_triggered = true
var solar_flare_start: int = -1
var debris_start: int = -1

@onready var random_event_timer = $EventTimer
@onready var solar_flare_timer = $SolarFlareTimer
@onready var debris_timer = $DebrisTimer


const GameTypes = preload("res://resources/templates/types.gd")

func _unhandled_input(event) -> void: 
	if event.is_action_pressed("events"):
		SceneManager.add_overlay("res://ui/EventFeed.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("terminal"):
		SceneManager.add_overlay("res://ui/Terminal.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	

func _ready():

	_on_event_timer_timeout()

func _process(delta):
	game_time += delta
	accumulated_time += delta
	apply_random_events()
	var minutes = GameManager.stats.seconds_per_calc
	if accumulated_time >= 1.0 * minutes:
		print(GameManager.active_events)
		update_game_logic(game_time)
		accumulated_time -= 1.0 * minutes

func update_game_logic(delta):
	if !game_over():
		apply_ship_damage()
		apply_oxygen_change()
		apply_weapons_damage()
		apply_crew_damage()
		apply_ship_events(delta)
		apply_ship_movement()
		# print(GameManager.stats.ship_damage)

func game_over() -> bool:
	if GameManager.stats.distance >= GameManager.stats.target_distance:
		print("Game won")
		SceneManager.change_scene("a")
		return true
	if len(GameManager.crew_members) == 0:
		print("Crew died")
		SceneManager.change_scene("b")
		return true
	if GameManager.dead_crew_members.any(func(member: Crew): return member.location == GameTypes.Locations.ENGINE_ROOM):
		print("Player died")
		SceneManager.change_scene("b")
		return true
	return false

##
# Ship damage
##
func apply_ship_damage():
	var fire_count = 0
	for event in GameManager.active_events:
		if event.event == GameTypes.Events.FIRE:
			fire_count += 1
	if GameManager.stats.current_thrust == 3:
		GameManager.stats.ship_damage += GameManager.stats.thrust_3_damage
		
	GameManager.stats.ship_damage += GameManager.stats.starting_sun_damage
	GameManager.stats.ship_damage += fire_count*GameManager.stats.fire_ship_damage
	GameManager.emit_signal("change_ship_damage", GameManager.stats.ship_damage)


##
# Crew damage
##
func apply_crew_damage():
	for member in GameManager.crew_members:
		if GameManager.stats.current_oxygen <= GameManager.stats.low_oxygen:
			member.health -= GameManager.stats.crew_damage_low_oxygen
		elif GameManager.stats.current_oxygen >= GameManager.stats.high_oxygen:
			member.health -= GameManager.stats.crew_damage_high_oxygen

		if member.location in GameManager.active_event_locations.values():
			var fire_count = 0
			for event in GameManager.active_event_locations:
				if event.event == GameTypes.Events.FIRE:
					fire_count += 1
			member.health -= GameManager.stats.fire_crew_damage * fire_count
		
		if member.health > GameManager.stats.crew_defib_window:
			member.status = GameTypes.CrewStatus.VITALS_NORMAL
		elif member.health <= GameManager.stats.crew_defib_window and member.health > 0:
			member.status = GameTypes.CrewStatus.CRITICAL
		elif member.health <= 0:
			member.status = GameTypes.CrewStatus.DECEASED
			GameManager.dead_crew_members.append(member)

	GameManager.crew_members = GameManager.crew_members.filter(func(member): return member.health > 0)
	GameManager.emit_signal("crew_members_damaged")

		

# Unused function to randomly choose one member to afflict with fire damage
func select_crew_member(crew_members: Array[Crew]) -> Crew:
	var eligible_crew_members = []
	var captain = null
	var player = null
	
	for crew_member in crew_members:
		if crew_member.role == "Captain":
			captain = crew_member
		elif crew_member.name == "Player":
			player = crew_member
		else:
			eligible_crew_members.append(crew_member)
	
	if eligible_crew_members.size() > 0:
		var random_index = randi() % eligible_crew_members.size()
		return eligible_crew_members[random_index]
	elif captain != null:
		return captain
	else:
		return player

## 
# Ship events
##
func apply_ship_events(delta):
	var ship_damage = GameManager.stats.ship_damage
	var modulation_factor = calculate_sine_wave_modulation(delta, ship_damage)

	if modulation_factor >= 0.8 and not emergencies_triggered:
		var cluster_size = calculate_cluster_size(ship_damage)
		trigger_emergency_cluster(cluster_size)
		emergencies_triggered = true  
	
	if modulation_factor < 0.8:
		emergencies_triggered = false

func calculate_cluster_size(ship_damage):
	var max_ship_damage = GameManager.stats.max_ship_damage
	var min_cluster = GameManager.stats.min_cluster_emergencies_size
	var max_cluster = GameManager.stats.min_cluster_emergencies_size

	var damage_factor = ship_damage / max_ship_damage
	var cluster_size = round(lerp(min_cluster, max_cluster, damage_factor))
	return cluster_size

func calculate_sine_wave_modulation(current_time, ship_damage):
	var max_ship_damage = GameManager.stats.max_ship_damage
	var cluster_interval_min = GameManager.stats.cluster_peak_interval_min
	var cluster_interval_max = GameManager.stats.cluster_peak_interval_max

	var damage_factor = ship_damage / max_ship_damage
	var interval = lerp(cluster_interval_min, cluster_interval_max, damage_factor)
	return sin(TAU * current_time / interval)

func emergency_can_occur_again(event):
	return event == GameTypes.Events.FIRE || event == GameTypes.Events.HULLBREACH

func trigger_emergency_cluster(cluster_size):
	var possible_events = []
	for event in GameManager.events:	
		if event not in GameManager.active_events:
			possible_events.append(event)
		if emergency_can_occur_again(event.event):
			possible_events.append(event)
	for i in range(cluster_size):
		var total_weight = 0
		for event in possible_events:
			total_weight += event.weight
		
		# Calculate likelihood
		var random_weight = randi() % total_weight
		var cumulative_weight = 0
		var selected_event = null
		for event in possible_events:
			cumulative_weight += event.weight
			if random_weight < cumulative_weight:
				selected_event = event
				break

		if selected_event != null:
			if not emergency_can_occur_again(selected_event.event):
				possible_events.erase(selected_event)
			else:
				var location_keys = GameTypes.Locations.keys()
				GameManager.active_event_locations[selected_event] = location_keys.pick_random()

			GameManager.active_events.append(selected_event)
			GameManager.emit_signal("event_triggered", selected_event)
##
# Ship movement
##
func apply_ship_movement():
	var movement = - GameManager.stats.sun_gravity
	var thrust = GameManager.stats.current_thrust
	if thrust > 0:
		if thrust == 1:
			movement += GameManager.stats.thrust_1
		elif thrust == 2:
			movement += GameManager.stats.thrust_2
		elif thrust == 3:
			movement += GameManager.stats.thrust_3
	GameManager.stats.distance += movement
	GameManager.emit_signal("ship_moved", GameManager.stats.distance)

##
# O2
##
func apply_oxygen_change():
	var ox_power = GameManager.stats.current_atmosphere_generator
	if ox_power == 0:
		GameManager.stats.current_oxygen -= GameManager.stats.oxygen_depletion_atmosphere_generator
	elif ox_power == 2:
		GameManager.stats.current_oxygen += GameManager.stats.oxygen_regeneration
	
	for event in GameManager.active_events:
		if event.event == GameTypes.Events.FIRE:
			GameManager.stats.current_oxygen -= GameManager.stats.oxygen_depletion_fire
		elif event.event == GameTypes.Events.HULLBREACH:
			GameManager.stats.current_oxygen -= GameManager.stats.oxygen_depletion_hull_breach
	GameManager.emit_signal("change_oxygen", GameManager.stats.current_oxygen)

## 
# Weapons
##
func apply_weapons_damage():
	if GameManager.stats.current_weapons == GameManager.stats.weapons_on:
		if GameManager.stats.current_space_debris_health > 0:
			GameManager.stats.current_space_debris_health -= GameManager.stats.space_debris_weapons_damage
			GameManager.emit_signal("weapons_firing")

##
# Random events
##
func apply_random_events():
	if !solar_flare_triggered and solar_flare_start >= random_event_timer.time_left:
		var solar_flare_countdown = GameManager.stats.solar_flare_countdown

		solar_flare_triggered = true
		GameManager.emit_signal("warn_solar_flare", solar_flare_countdown)
		solar_flare_timer.start(solar_flare_countdown)

	if !debris_triggered and debris_start >= random_event_timer.time_left:
		var debris_countdown = GameManager.stats.space_debris_countdown
		var min_debris_health = GameManager.stats.space_debris_min_health
		var max_debris_health = GameManager.stats.space_debris_max_health

		debris_triggered = true
		GameManager.stats.current_space_debris_health = randi_range(min_debris_health, max_debris_health)
		GameManager.emit_signal("warn_debris", debris_countdown)
		debris_timer.start(debris_countdown)


func _on_debris_timer_timeout():
	if GameManager.stats.current_space_debris_health > 0:
		GameManager.emit_signal("space_debris_hit")
		GameManager.stats.ship_damage += GameManager.stats.space_debris_damage


func _on_solar_flare_timer_timeout():
	GameManager.emit_signal("solar_flare_hit")
	if GameManager.stats.current_shields != GameManager.stats.shields_on:
		trigger_emergency_cluster(GameManager.stats.solar_flare_emergencies_size)


func _on_event_timer_timeout():
	var event_interval = GameManager.stats.random_event_interval
	if solar_flare_timer.is_stopped():
		solar_flare_start = randi_range(1, event_interval - 1)
	
	if debris_timer.is_stopped():
		debris_start = randi_range(1, event_interval - 1)
	
	solar_flare_triggered = false
	debris_triggered = false
	random_event_timer.start(event_interval)

