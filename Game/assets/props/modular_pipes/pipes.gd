extends GridMap

@export var vfx: Array[GPUParticles3D] = []
var o2_failure: GameEvent = null
signal fix();

func _ready():
	fix.connect(_on_fix)
	GameManager.connect_to_signal("event_triggered", self, "_on_event_triggered")

func _on_event_triggered(event: GameEvent):
	if event.event == GameEvent.GameTypes.Events.ATMOSPHERE_GENERATOR:
		o2_failure = event
		for fx in vfx:
			fx.emitting = true

func _on_fix():
	print("pipe fixing")
	if not o2_failure:
		return
	var fixed = 0
	for fx in vfx:
		fixed += 1
		if fx.emitting:
			fx.emitting = false
			break
	if fixed == vfx.size():
		GameManager.active_events.erase(o2_failure)
		o2_failure = null

