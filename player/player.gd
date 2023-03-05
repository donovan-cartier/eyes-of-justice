extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var can_move_body = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Object interaction
@onready var interact_raycast = $CameraRoot/Camera3D/InteractRaycast
var aimed_object
var inspected_object

@onready var camera = $CameraRoot

#Player movement modes
enum MODES {
	FULL_MOVEMENT,
	CAMERA_ONLY,
	INSPECT,
	MOVE_NOT_ALLOWED
}

var current_mode = MODES.CAMERA_ONLY

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()
	
	if can_move_body:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	
	#Check raycast collision for objects
	if interact_raycast.is_colliding() && current_mode != MODES.INSPECT:
		aimed_object = interact_raycast.get_collider()
		aimed_object.get_node("RaycastBehavior").highlight()
	#If no interactable objects, reset aimed_object var
	else:
		if aimed_object != null:
			aimed_object.get_node("RaycastBehavior").stop_highlight()
			aimed_object = null

func _process(delta):
	#On action (LMB) pressed
	if Input.is_action_just_pressed("action"):
		#If player is currently inspecting an object
		if current_mode == MODES.INSPECT:
			inspected_object.get_node("RaycastBehavior").stop_inspect()
			current_mode = MODES.CAMERA_ONLY
			
		#Else, if an object is aimed at, interact with it
		elif aimed_object != null:
			aimed_object.get_node("RaycastBehavior").interact()

#START OBJECT INSPECTION
func inspect_object(object):
	camera.disable_movement()
	inspected_object = object
	current_mode = MODES.INSPECT
