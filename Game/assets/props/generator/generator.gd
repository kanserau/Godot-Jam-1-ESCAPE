extends Node3D

signal fix();
@onready var animation: AnimationPlayer = $AnimationPlayer
var captured_event: GameEvent = null

func _ready():
	GameManager.event_triggered.connect(_on_event_triggered)
	fix.connect(_on_fix)
	animation.queue("stop")

func _on_event_triggered(event: GameEvent):
	if event.event != GameTypes.Events.ENGINE:
		return
	captured_event = event
	animation.queue("start")

func _on_fix():
	animation.queue("stop")
	GameManager.active_events.erase(captured_event)
	captured_event = null
