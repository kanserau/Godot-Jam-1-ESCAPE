extends AudioStreamPlayer3D
class_name EngineSFX

@export var on_sfx: AudioStream
@export var off_sfx: AudioStream

func _ready():
	stream = on_sfx
	play()

func toggle(on: bool):
	if on:
		stream = on_sfx
		play()
	else:
		stream = off_sfx
		play()

func check():
	if stream == on_sfx and GameManager.stats.current_thrust == 0:
		toggle(false)
	elif stream == off_sfx and GameManager.stats.current_thrust > 0:
		toggle(true)
