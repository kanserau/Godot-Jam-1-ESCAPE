extends GridMap

@export var vfx: Array[GPUParticles3D] = []
@export var sfx: Array[AudioStream] = []
@export var sfx_loop: AudioStream = null
@export var sfx_player: AudioStreamPlayer3D = null

var o2_failure: Array[GameEvent] = []
signal fix();

func _ready():
	fix.connect(_on_fix)
	GameManager.event_triggered.connect(_on_event_triggered)

func _on_event_triggered(event: GameEvent):
	if event.event != GameTypes.Events.ATMOSPHERE_GENERATOR:
		return
	o2_failure.append(event)
	for fx in vfx:
		fx.emitting = true
	if sfx.size() > 0:
		sfx_player.stream = sfx.pick_random()
	else:
		sfx_player.stream = sfx_loop
	sfx_player.play()

func _on_sfx_finish():
	sfx_player.stream = sfx_loop
	sfx_player.play()

func _on_fix():
	if not o2_failure:
		return
	var fixed = 0
	for fx in vfx:
		fixed += 1
		if fx.emitting:
			fx.emitting = false
			break
	if fixed == vfx.size():
		sfx_player.stop()
		while not o2_failure.is_empty():
			GameManager.active_events.erase(o2_failure.pop_back())

