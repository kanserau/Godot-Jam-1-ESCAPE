extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var multitool_hit_src: AudioStreamPlayer3D
@export var multitool_swing_src: AudioStreamPlayer3D
@export var multitool_hits: Array[AudioStream]
@export var multitool_swings: Array[AudioStream]
@export var stompers: AudioStreamPlayer3D
@export var stomps:  Array[AudioStream]
@export var stomp_timer: Timer

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D



var target_neck_rotation = 0.0
var target_camera_rotation = 0.0

# Listens to everything
func _unhandled_input(event) -> void: 
	if get_tree().paused:
		return

	if event.is_action_pressed("escape"):
		SceneManager.pause_game()
		SceneManager.add_overlay("res://ui/SettingsUI.tscn")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if event.is_action_pressed("fix") and not $AnimationPlayer.is_playing():
		$AnimationPlayer.queue("fix")
		multitool_swing_src.stream = multitool_swings.pick_random()
		multitool_swing_src.play()
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.001)
			camera.rotate_x(-event.relative.y * 0.001)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if !SceneManager.overlay_active():
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		if is_on_floor() and (velocity.x != 0 or velocity.z != 0) and stomp_timer.time_left <= 0:
			stompers.stream = stomps.pick_random()
			stompers.play()
			stompers.pitch_scale = randf_range(0.5, 1.2)
			stomp_timer.start()
	else:
		velocity.x = 0
		velocity.z = 0
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.has_signal("fix"):
		body.emit_signal("fix")
		multitool_hit_src.stream = multitool_hits.pick_random()
		multitool_hit_src.play()
