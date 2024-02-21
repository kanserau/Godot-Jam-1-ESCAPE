extends AudioStreamPlayer3D

@export var engine_failure: AudioStream
@export var pilot_dead: AudioStream

func _ready():
	GameManager.event_triggered.connect(on_event)
	GameManager.crew_members_damaged.connect(on_crew_damaged)

func on_crew_damaged():
	pass

func on_event(event: GameEvent):
	match event.event:
		GameTypes.Events.ENGINE:
			stream = engine_failure
			play()
