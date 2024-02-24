extends AudioStreamPlayer3D

@export var annoucement_delay = 0.5
@export var intro: AudioStream
var system_down = {}
var system_up = {}
var external_detected = {}
var external_resolved = {}
var external_prevented = {}
var played = {}
var timer: SceneTreeTimer = null


func _ready():
	for i in DynamicLoader.load_from("res://resources/annoucements/system_failures"):
		var e = i as SystemDownAnnoucement
		if e.trigger not in system_down:
			system_down[e.trigger] = [] as Array[SystemDownAnnoucement]
		system_down[e.trigger].append(e)
		played[e] = 0
	
	if intro:
		stream = intro
		play()
		finished.connect(_on_intro_finished)
	GameManager.event_triggered.connect(on_event)
	GameManager.crew_members_damaged.connect(on_crew_damaged)
	GameManager.warn_debris.connect(on_warn_debris)
	GameManager.space_debris_hit.connect(on_debris_hit)
	GameManager.warn_solar_flare.connect(on_warn_solar)
	GameManager.solar_flare_hit.connect(on_solar_hit)

func _on_intro_finished():
	if stream != intro:
		finished.disconnect(_on_intro_finished)
		return
	GameManager.intro_finished = true
	finished.disconnect(_on_intro_finished)

func on_crew_damaged():
	if GameManager.dead_crew_members.has(func (c): return c.role.to_lower() == 'captain'):
		queue_free()

func on_warn_debris():
	pass

func on_debris_hit():
	pass
	
func on_warn_solar():
	pass
	
func on_solar_hit():
	pass

func on_event(event: GameEvent):
	if playing or timer != null and timer.time_left > 0:
		return
	if GameManager.dead_crew_members.any(func(c): return c.role == 'Captain'):
		return
	if not event.event in system_down.keys():
		return
	var lines: Array[SystemDownAnnoucement] = system_down[event.event]
	var not_played_probability = lines.map(func (e): return played[e]).max() + 1
	var probabilities = []
	var cum = 0
	for e in lines:
		var cur = not_played_probability - played[e]
		probabilities.append(cum + cur)
		cum += cur
	var i = probabilities.bsearch(randi_range(0, cum))
	var selected = lines[i]
	if randf() > 1.0 / (played[selected] + 1.0):
		return
	played[selected] += 1
	stream = selected.audio
	timer = get_tree().create_timer(annoucement_delay)
	timer.timeout.connect(play)
	
