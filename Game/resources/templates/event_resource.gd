extends Resource

class_name GameEvent 

const GameTypes = preload("res://resources/templates/types.gd")

@export var event: GameTypes.Events
@export var weight: int
