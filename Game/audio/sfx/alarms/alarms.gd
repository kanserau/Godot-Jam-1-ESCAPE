extends Node3D

@export var fire: AudioStreamPlayer3D
@export var space_debris: AudioStreamPlayer3D
@export var solar_flare: AudioStreamPlayer3D

func _ready():
	GameManager.event_triggered.connect(on_event)
	GameManager.warn_solar_flare.connect(on_flare)
	GameManager.warn_debris.connect(on_debris)
	GameManager.update_everything.connect(update)

func update():
	if not GameManager.solar_flare_incoming or GameManager.stats.current_shields:
		solar_flare.stop()
	if not GameManager.debris_incoming:
		space_debris.stop()
	if not GameManager.active_events.any(func(e): return e.event == GameTypes.Events.FIRE):
		fire.stop()

func on_flare(_timer):
	solar_flare.play()
	
func on_debris(_timer):
	space_debris.play()

func on_event(event: GameEvent):
	match event.event:
		GameTypes.Events.FIRE:
			fire.play()
