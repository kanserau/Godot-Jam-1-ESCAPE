extends AudioStreamPlayer

const GameTypes = preload("res://resources/templates/types.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	SettingsManager.connect_bgm_volume_change_listener(self, "on_volume_changed")
	#GameManager.connect_to_signal(self, "event_triggered", on_event_triggered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_volume_changed(new_volume_db):
	self.volume_db = new_volume_db

#func on_event_triggered(event: GameEvent):
	#self.pla
	#if event.event == GameTypes.Events.FIRE:
		#play fire voice line
#	pass
