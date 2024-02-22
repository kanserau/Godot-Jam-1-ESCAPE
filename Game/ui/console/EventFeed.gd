extends Control

@onready var container = $Panel/MarginContainer/ScrollContainer/EventContainer

const label_theme = preload("res://resources/settings_theme.tres")
var event_labels = []
var game_time = 0.0
var accumulated_time = 0.0

func _ready():
	GameManager.event_triggered.connect(_on_event_triggered)
	GameManager.update_everything.connect(update_active_events)
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
			# TODO: CRITICAL BUG!!
			# active events contains duplicate objects
			# locations are overwritten when objects duplicate events are added
			# when one of duplicate is resolved, the remaining events have no locations
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

func _on_event_triggered(_event: GameEvent):
	update_active_events()
	
