extends Node3D

enum FireState {
	NONE,
	BIG,
	MEDIUM,
	SMOKE,
}

signal fix();
@onready var animation: AnimationPlayer = $AnimationPlayer
var state = FireState.NONE
var captured_event: Array[GameEvent] = []

func _ready():
	GameManager.event_triggered.connect(_on_event_triggered)
	fix.connect(_on_fix)


func _on_event_triggered(event: GameEvent):
	if event.event != GameTypes.Events.FIRE:
		return
	if GameManager.active_event_locations[event] != "ENGINE_ROOM":
		return
	captured_event.append(event)
	state = FireState.BIG
	animation.queue("fire_big")



func _on_fix():
	match state:
		FireState.BIG:
			state = FireState.MEDIUM
			animation.queue("fire_medium") 
		FireState.MEDIUM:
			state = FireState.SMOKE
			animation.queue("fire_smoke") 
		FireState.SMOKE:
			state = FireState.NONE
			animation.queue("fire_none")
			for c in captured_event:
				GameManager.active_event_locations.erase(c)
				GameManager.active_events.erase(c)
			captured_event.clear()
