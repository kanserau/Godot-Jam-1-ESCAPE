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
#
	#if event == GameTypes.SystemFailures:
		#match SystemFailures:
			#POWER_GENERATOR:
				#$Captain.play("")
			#ENGINE:
				#$Captain.play("ship engines")
			#ATMOSPHERE_GENERATOR:
				#$Captain.play("")
			#SHIELDS:
				#$Captain.play("")
			#WEAPONS:
				#$Captain.play("")
			#TERMINAL
				#$Captain.play("")
	#if event.event == GameTypes.CrewStatus.DECEASED
		#match Deceased:
			#Pilot: 
				#$Captain.play("pilot_dead")
			#Chef:
				#$Captain.play("")
			#Gunner:
				#$Captain.play("")
			#Captain:
				#$Captain.play("")
			#Doctor:
				#$Captain.play("")
			#Researcher:
				#$Captain.play("")
			#SecondTech
				#$Captain.play("")
				
