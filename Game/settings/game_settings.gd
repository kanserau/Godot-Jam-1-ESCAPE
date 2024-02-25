extends Node

class_name GameSettings

signal master_volume_changed(new_master_volume)
signal bgm_volume_changed(new_bgm_volume)
signal sfx_volume_changed(new_sfx_volume)
signal vo_volume_changed(new_vo_volume)

@export var master_volume: float = 0.0:
	set(value):
		master_volume = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
		master_volume_changed.emit(value)

@export var bgm_volume: float = 0.0:
	set(value):
		bgm_volume = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)
		bgm_volume_changed.emit(value)

@export var sfx_volume: float = 0.0:
	set(value):
		sfx_volume = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
		sfx_volume_changed.emit(value)
	
@export var vo_volume: float = 0.0:
	set(value):
		vo_volume = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("VO"), value)
		vo_volume_changed.emit(value)
