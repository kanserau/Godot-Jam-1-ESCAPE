extends Node

class_name GameSceneManager

var current_scene: Node = null
var current_overlay: Node = null

func change_scene_and_delete(path) -> void:
	# add preprocessing later 
	# loader?
	get_tree().change_scene_to_file(path)

func change_scene(path) -> void:
	if current_scene:
		current_scene.queue_free()
		
		
	var new_scene = load(path).instantiate()
	current_scene = new_scene
	get_tree().root.add_child(new_scene)

func add_overlay(path) -> void:
	var overlay_scene = load(path).instantiate()
	current_overlay = overlay_scene
	get_tree().root.add_child(overlay_scene)


func remove_overlay() -> void:
	if current_overlay:
		get_tree().root.remove_child(current_overlay)
		current_overlay.queue_free()
		current_overlay = null
		
func overlay_active() -> bool:
	return current_overlay != null

func pause_game() -> void:
	get_tree().paused = true

func unpause_game() -> void:
	get_tree().paused = false

func _ready():
	pass 


func _process(_delta):
	pass
