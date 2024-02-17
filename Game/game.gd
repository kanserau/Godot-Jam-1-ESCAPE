extends Node

var game_time = 0.0
var accumulated_time = 0.0
var previous_modulation_factor = 0.0
var emergencies_triggered = false

const GameTypes = preload("res://resources/templates/types.gd")

func _ready():
	pass

func _process(delta):
	game_time += delta
	accumulated_time += delta
	var minutes = GameManager.stats.seconds_per_calc
	if accumulated_time >= 1.0 * minutes:
		update_game_logic(game_time)
		accumulated_time -= 1.0 * minutes

func update_game_logic(delta):
	if !game_over():
		apply_ship_damage()
		apply_crew_damage()
		apply_ship_events(delta)
		apply_ship_movement()
		# print(GameManager.stats.ship_damage)

func game_over() -> bool:
	if GameManager.stats.distance >= GameManager.stats.target_distance:
		SceneManager.change_scene("a")
		return true
	if len(GameManager.crew_members) == 0:
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
		
	GameManager.stats.ship_damage += GameManager.stats.starting_sun_damage
	GameManager.stats.ship_damage += fire_count*GameManager.stats.fire_ship_damage
	GameManager.emit_signal("change_ship_damage", GameManager.stats.ship_damage)


##
# Crew damage
##
func apply_crew_damage():
	if GameManager.stats.current_oxygen <= GameManager.stats.low_oxygen:
		for member in GameManager.crew_members:
			member.health -= GameManager.stats.crew_damage_low_oxygen
	elif GameManager.stats.current_oxygen >= GameManager.stats.high_oxygen:
		for member in GameManager.crew_members:
			member.health -= GameManager.stats.crew_damage_high_oxygen
	# TODO: Apply fire damage here
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
	return event == GameTypes.Events.FIRE || GameTypes.Events.HULLBREACH

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
			GameManager.emit_signal("event_triggered", selected_event)
			GameManager.active_events.append(selected_event)
			if not emergency_can_occur_again(selected_event.event):
				possible_events.erase(selected_event)

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
