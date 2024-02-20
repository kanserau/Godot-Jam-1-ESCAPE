extends Control

@onready var master_slider = $"MarginContainer/ScrollContainer/VBoxContainer/Master/master_slider"
@onready var bgm_slider = $"MarginContainer/ScrollContainer/VBoxContainer/BGM/bgm_slider"
@onready var sfx_slider = $"MarginContainer/ScrollContainer/VBoxContainer/SFX/sfx_slider"
@onready var voice_slider = $"MarginContainer/ScrollContainer/VBoxContainer/Voice/voice_slider"


func _unhandled_input(event):
	if event.is_action_pressed("escape") and not event.is_echo():
		get_viewport().set_input_as_handled()
		SceneManager.remove_overlay()
		SceneManager.unpause_game()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _ready():
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	master_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	master_slider.value = SettingsManager.settings.master_volume
	
	bgm_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	bgm_slider.value = SettingsManager.settings.bgm_volume

	sfx_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	sfx_slider.value = SettingsManager.settings.sfx_volume
	
	voice_slider.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	voice_slider.value = SettingsManager.settings.vo_volume


func _on_master_value_changed(value):
	SettingsManager.settings.master_volume = value
	SettingsManager.save_settings()

func _on_sfx_value_changed(value):
	SettingsManager.settings.sfx_volume = value
	SettingsManager.save_settings()

func _on_bgm_value_changed(value):
	SettingsManager.settings.bgm_volume = value
	SettingsManager.save_settings()

func _on_vo_value_changed(value):
	SettingsManager.settings.vo_volume = value
	SettingsManager.save_settings()
