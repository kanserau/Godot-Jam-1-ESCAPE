extends Node

class_name GameSettingsManager

var settings: GameSettings = GameSettings.new()

func _ready():
	add_child(settings)
	load_settings()

# Sound 
func connect_sfx_volume_change_listener(listener_node, listener_method):
	settings.connect("sfx_volume_changed", Callable(listener_node, listener_method))

func connect_bgm_volume_change_listener(listener_node, listener_method):
	settings.connect("bgm_volume_changed", Callable(listener_node, listener_method))

# Persistence
func save_settings():
	var config = ConfigFile.new()
	for property in settings.get_property_list():
		if property.usage & PROPERTY_USAGE_STORAGE:
			config.set_value("audio", property.name, settings.get(property.name))
	var error = config.save("user://settings.cfg")
	if error != OK:
		print("Failed to save settings: ", error)

func load_settings():
	var config = ConfigFile.new()
	var error = config.load("user://settings.cfg")
	if error != OK:
		print("Failed to load settings: ", error)
		return
	var audio_settings = config.get_section_keys("audio")
	for setting in audio_settings:
		var value = config.get_value("audio", setting)
		if setting in settings:
			settings.set(setting, value)
