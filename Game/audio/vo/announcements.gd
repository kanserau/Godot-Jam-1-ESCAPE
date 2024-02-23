extends AudioStreamPlayer3D

var annoucements: Array[FailureAnnoucement] = []
var triggers = {}
var played = {}

func _ready():
	for i in DynamicLoader.load_from("res://resources/annoucements"):
		if not i is FailureAnnoucement:
			continue
		var e = i as FailureAnnoucement
		annoucements.append(e)
		if e.trigger not in triggers:
			triggers[e.trigger] = [] as Array[FailureAnnoucement]
		triggers[e.trigger].append(e)
		played[e] = 0
	
	GameManager.event_triggered.connect(on_event)
	GameManager.crew_members_damaged.connect(on_crew_damaged)
	GameManager.space_debris_hit.connect(on_debris_hit)
	GameManager.solar_flare_hit.connect(on_solar_hit)

func on_crew_damaged():
	if GameManager.dead_crew_members.has(func (c): return c.role.to_lower() == 'captain'):
		queue_free()
	
func on_debris_hit():
	pass
	
func on_solar_hit():
	pass

func on_event(event: GameEvent):
	if not event.event in triggers.keys():
		return
	var lines: Array[FailureAnnoucement] = triggers[event.event]
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
	play()
	
