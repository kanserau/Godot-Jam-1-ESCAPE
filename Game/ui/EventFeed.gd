extends Control

@onready var container = $ScrollContainer/EventContainer

const GameTypes = preload("res://resources/templates/types.gd")
const label_theme = preload("res://resources/settings_theme.tres")
var event_labels = []
var game_time = 0.0
var accumulated_time = 0.0

func _unhandled_input(event):
	get_viewport().set_input_as_handled()
	if event.is_action_pressed("escape") and not event.is_echo():
		SceneManager.remove_overlay()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#
#func _unhandled_input(event):
	#if event.is_action_pressed("escape") and not event.is_echo():
		#get_viewport().set_input_as_handled()
		#SceneManager.remove_overlay()

func _input(event):
	if event.is_action_pressed("escape"):
		get_viewport().set_input_as_handled()
		SceneManager.remove_overlay()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_viewport().set_input_as_handled()

func _ready():
	GameManager.connect("event_triggered", Callable(self, "_on_event_triggered"))
	GameManager.connect("update_everything", Callable(self, "update_everything"))
	update_active_events()

func _process(delta):
	game_time += delta
	accumulated_time += delta
	if accumulated_time >= 1.0:
		accumulated_time -= 1.0
		update_active_events()

func create_label(text) -> Label:
	var label = Label.new()
	label.theme = label_theme
	label.theme_type_variation = 'event-feed'
	label.text = text
	return label	

func update_active_events():
	for label in event_labels:
		label.queue_free()
	event_labels.clear()
	for event in GameManager.active_events:
		var event_label = create_label("Event Active: " + GameTypes.Events.keys()[event.event].replace("_", " "))
		if event.event == GameTypes.Events.FIRE || event.event == GameTypes.Events.HULLBREACH:
			event_label.text += " - location: "
			event_label.text += GameManager.active_event_locations[event]
		container.add_child(event_label)
		event_labels.append(event_label)
	if GameManager.solar_flare_incoming:
		var event_label = create_label("SOLAR FLARE INCOMING - TURN ON SHIELDS")
		container.add_child(event_label)
		event_labels.append(event_label)
	if GameManager.debris_incoming:
		var event_label = create_label("DEBRIS INCOMING - TURN ON WEAPONS")
		container.add_child(event_label)
		event_labels.append(event_label)
			

func update_everything():
	update_active_events()

func _on_event_triggered(_event: GameEvent):
	update_active_events()
	
