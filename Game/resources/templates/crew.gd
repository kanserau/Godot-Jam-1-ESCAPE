class_name Crew extends Resource

const GameTypes = preload("res://resources/templates/types.gd")

@export var id: String
@export var name: String
@export var role: String
@export var location: GameTypes.Locations
@export var status: GameTypes.CrewStatus
