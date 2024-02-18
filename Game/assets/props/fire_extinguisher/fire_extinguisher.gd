extends Node3D

signal fix();

@onready var explosion: GPUParticles3D = $GPUParticles3D
@onready var timer: Timer = $Timer

func _ready():
	fix.connect(_on_fix)

func _on_fix():
	explosion.emitting = true
	timer.start(explosion.lifetime)

func _on_timer_timeout():
	queue_free()
