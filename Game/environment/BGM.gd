extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SettingsManager.connect_bgm_volume_change_listener(self, "on_volume_changed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_volume_changed(new_volume_db):
	self.volume_db = new_volume_db
