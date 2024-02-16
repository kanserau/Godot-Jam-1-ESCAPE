extends Control

@onready var bgm_slider = $"ScrollContainer/VBoxContainer/HSplitContainer/BGM Slider"
@onready var sfx_slider = $"ScrollContainer/VBoxContainer/HSplitContainer2/SFX Slider"



func _unhandled_input(event):
	if event.is_action_pressed("escape") and not event.is_echo():
		get_viewport().set_input_as_handled()
		SceneManager.remove_overlay()
		SceneManager.unpause_game()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _ready():
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	bgm_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	bgm_slider.value = SettingsManager.settings.bgm_volume

	sfx_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	sfx_slider.value = SettingsManager.settings.sfx_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_bgm_value_changed(value):
	SettingsManager.settings.set_bgm_volume(value)
	SettingsManager.save_settings()


func _on_sfx_value_changed(value):
	SettingsManager.settings.set_sfx_volume(value)
	SettingsManager.save_settings()
