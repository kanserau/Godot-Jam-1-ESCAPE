extends Resource

class_name GameResource

@export var starting_power: int  = 4
@export var minutes_per_second: int = 1

@export var thrust_1: int = 100
@export var thrust_2: int = 400
@export var thrust_3: int = 600

@export var oxygen_low_concentration: int = 0
@export var oxygen_maintained: int = 1
@export var oxygen_high_concentration: int = 2
@export var low_oxygen: int = 200
@export var high_oxygen: int = 400
@export var oxygen_depletion_atmosphere_generator: int = 30
@export var oxygen_depletion_hull_breach: int = 40
@export var oxygen_regeneration: int = 20

@export var shields_on: int = 2

@export var weapons_on: int = 2

@export var initial_distance: float = 0.0
@export var target_distance: float = 270000

@export var sun_gravity: int = 100
@export var starting_sun_damage: float = 10

# per min
@export var emergency_cluster_frequency: float = 0.2
@export var starting_number_cluster_emergencies: int = 2
@export var ship_damage_emergency_rate_multiplier: float = 1.0
@export var ship_damage_emergency_quantity_multiplier: float = 1.0

@export var solar_flare_countdown: int = 10
@export var space_debris_countdown: int = 10
@export var space_debris_min_health: int = 200
@export var space_debris_max_health: int = 300

@export var fire_spread_rate: float = 0.2
@export var fire_crew_damage: int = 10
@export var fire_ship_damage: int = 10
@export var hull_breach_ship_damage: int = 10

@export var crew_health: int = 50
@export var crew_defib_window: int = 5

@export var prime_power_generator: int = 2
@export var ignition_power_generator: int = 1
@export var crowbar_terminal_hits: int = 4


