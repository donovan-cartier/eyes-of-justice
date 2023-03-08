extends Node3D

const SENSITIVITY = 0.1
const SMOOTHNESS = 10

@onready var camera = $Camera3D
var camera_input : Vector2
var rotation_velocity : Vector2

var can_move_camera = true
@onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		camera_input = event.relative

func _process(delta):
	#Rotate either the camera or something else
	rotation_velocity = rotation_velocity.lerp(camera_input * SENSITIVITY, delta * SMOOTHNESS)
	
	#Check current mode to define what to rotate
	match(player.current_mode):
	#	Rotate camera in camera only mode
		player.MODES.CAMERA_ONLY:
			rotate_y(-deg_to_rad(rotation_velocity.x))
			camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -60, 60)
			rotation_degrees.y = clamp(rotation_degrees.y, -60, 60)
			camera.rotate_x(-deg_to_rad(rotation_velocity.y))
			
		#Rotate 3D object in inspect mode
		player.MODES.INSPECT:
			player.inspected_object.rotate_y(-deg_to_rad(rotation_velocity.x))
			player.inspected_object.rotate_x(-deg_to_rad(rotation_velocity.y))
			
		player.MODES.FULL_MOVEMENT:
			player.rotate_y(-deg_to_rad((camera_input * SENSITIVITY).x))
			rotate_x(-deg_to_rad((camera_input * SENSITIVITY).y))
			rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
			
	camera_input = Vector2.ZERO

#Disable camera movement
func disable_movement():
	can_move_camera = false

#Enable camera movement
func enable_movement():
	can_move_camera = true
