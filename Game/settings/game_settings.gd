extends Node

class_name GameSettings

signal bgm_volume_changed(new_bgm_volume)
signal sfx_volume_changed(new_sfx_volume)

@export var bgm_volume: float = -10.0
@export var sfx_volume: float = -10.0

func set_bgm_volume(value):
	bgm_volume = value
	emit_signal("bgm_volume_changed", bgm_volume)

func set_sfx_volume(value):
	sfx_volume = value
	emit_signal("sfx_volume_changed", sfx_volume)

