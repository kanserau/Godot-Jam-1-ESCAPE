extends Control

@onready var engine_display = get_node('%Engine/TextureProgressBar')
@onready var o2_display = get_node('%O2/TextureProgressBar')
@onready var shields_display = get_node('%Shields/TextureProgressBar')
@onready var weapons_display = get_node('%Weapons/TextureProgressBar')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
