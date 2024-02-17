extends Node3D
class_name PowerButton

var power_failure: GameEvent = null
signal fix();
signal power_restored();

func _ready():
	fix.connect(_on_fix)

func power_failure_triggered(event: GameEvent):
	power_failure = event
	$AnimationPlayer.queue("static")

func _on_fix():
	if power_failure == null:
		return
	$AnimationPlayer.queue("push")

func _on_animation_player_animation_finished(anim_name: String):
	if anim_name == "push" and power_failure != null:
		GameManager.active_events.erase(power_failure)
		power_failure = null
		power_restored.emit()
