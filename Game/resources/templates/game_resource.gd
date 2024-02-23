extends Resource

class_name GameResource

@export var total_starting_power: int  = 4
@export var current_thrust: int = 2
@export var current_atmosphere_generator: int = 1
@export var current_shields: int = 0
@export var current_weapons: int = 0
@export var seconds_per_calc: int = 1

@export var ship_damage: float = 0.0
@export var max_ship_damage: float = 10000.0

func ship_integrity_percent():
	return 100.0 * (max_ship_damage - ship_damage)/max_ship_damage

@export var thrust_1: int = 100
@export var thrust_2: int = 400
@export var thrust_3: int = 600
@export var thrust_3_damage: int = 100

@export var current_oxygen: int = 300
@export var oxygen_low_concentration: int = 0
@export var oxygen_maintained: int = 1
@export var oxygen_high_concentration: int = 2
@export var low_oxygen: int = 200
@export var medium_oxygen: int = 300
@export var high_oxygen: int = 400
@export var oxygen_depletion_atmosphere_generator: int = 10
@export var oxygen_depletion_hull_breach: int = 5
@export var oxygen_depletion_fire: int = 5
@export var oxygen_regeneration: int = 20

@export var shields_on: int = 2

@export var weapons_on: int = 2

@export var distance: float = 0.0
@export var target_distance: float = 270000

func distance_percent():
	return 100.0 * distance/target_distance

@export var sun_gravity: int = 100
@export var starting_sun_damage: float = 10

# at peak
@export var min_cluster_emergencies_size: int = 1
@export var max_cluster_emergencies_size: int = 5
# period
@export var cluster_peak_interval_min: int = 20
@export var cluster_peak_interval_max: int = 2

@export var random_event_interval: int = 30

@export var solar_flare_countdown: int = 10
@export var solar_flare_emergencies_size: int = 2

@export var current_space_debris_health: int = 0
@export var space_debris_countdown: int = 10
@export var space_debris_min_health: int = 200
@export var space_debris_max_health: int = 300
@export var space_debris_weapons_damage: int = 50
@export var space_debris_damage: int = 200

@export var fire_spread_rate: float = 0.2
@export var fire_crew_damage: int = 10
@export var fire_ship_damage: int = 10
@export var hull_breach_ship_damage: int = 10

@export var crew_health: int = 50
@export var crew_defib_window: int = 15
@export var crew_defib_regeneration: int = 20
@export var crew_damage_low_oxygen: int = 10
@export var crew_damage_high_oxygen: int = 5

@export var prime_power_generator: int = 2
@export var ignition_power_generator: int = 1
@export var crowbar_terminal_hits: int = 4


