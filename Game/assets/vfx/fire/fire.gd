extends Node3D

signal fix();
@onready var smoke: GPUParticles3D = $node/smoke
@onready var rising_flame: GPUParticles3D = $"node/rising flame"
@onready var base_flame: GPUParticles3D = $"node/base flame"
@onready var light: Light3D = $"node/OmniLight3D"
@onready var collider: StaticBody3D = $node/StaticBody3D

func _ready():
	GameManager.connect_to_signal("cd", self, "_on_event_triggered")
	fix.connect(_on_fix)

# TODO:
# - adjust amount of particles
# - move numbers to @export var

func _on_event_triggered(event: GameEvent):
	if event.event != GameEvent.GameTypes.Events.FIRE:
		return
	
	smoke.emitting = true
	smoke.lifetime = 10
	
	base_flame.emitting = true
	
	rising_flame.emitting = true
	rising_flame.lifetime = 2.5
	
	light.light_energy = 5
	
	collider.visible = true



func _on_fix():
	if base_flame.emitting:
		base_flame.emitting = false
		rising_flame.lifetime = 0.8
		light.light_energy = 3
		return
		
	if rising_flame.emitting:
		rising_flame.emitting = false
		light.light_energy = 0
		return
	
	if smoke.emitting:
		smoke.lifetime = 1
		smoke.emitting = false
		collider.visible = false
