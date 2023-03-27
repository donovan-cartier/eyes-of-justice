extends CharacterBody3D
class_name Player

const SPEED = 2
const JUMP_VELOCITY = 3

var can_move_body = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Object interaction
@onready var interact_raycast = $CameraRoot/Camera3D/InteractRaycast
var aimed_object
var inspected_object

@onready var camera = $CameraRoot
@onready var camera3D = $CameraRoot/Camera3D
@onready var camera_anim = $CameraRoot/Camera3D/AnimationPlayer


#Player movement modes
enum MODES {
	FULL_MOVEMENT,
	CAMERA_ONLY,
	INSPECT,
	MOVE_NOT_ALLOWED
}

@export var current_mode = MODES.CAMERA_ONLY
var previous_mode

func _ready():
	pass
#start dialogue box (debug)
#	$DialogueBox.start(load("res://dialogues/test.dialogue"), "this_is_a_node_title")

func _physics_process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().quit()
	
	if current_mode == MODES.FULL_MOVEMENT:
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
			camera_anim.play("head_bob")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	
	#Check raycast collision for objects
	if interact_raycast.is_colliding() && current_mode != MODES.INSPECT:
		aimed_object = interact_raycast.get_collider()
		if aimed_object.is_in_group("interact"):
			aimed_object.get_node("RaycastBehavior").highlight()
	#If no interactable objects, reset aimed_object var
	else:
		if aimed_object != null:
			if aimed_object.is_in_group("interact"):
				aimed_object.get_node("RaycastBehavior").stop_highlight()
				aimed_object = null

func _process(delta):
	#On action (LMB) pressed
	if Input.is_action_just_pressed("action"):
		#If player is currently inspecting an object, stop
		if current_mode == MODES.INSPECT:
			inspected_object.get_node("RaycastBehavior").stop_inspect()
			current_mode = previous_mode
			
		#Else, if an object is aimed at, interact with it
		elif aimed_object != null:
			if aimed_object.is_in_group("interact"):
				aimed_object.get_node("RaycastBehavior").interact()

#START OBJECT INSPECTION
func inspect_object(object):
	camera.disable_movement()
	inspected_object = object
	set_movement_mode(MODES.INSPECT)
	
	
func _input(event):
#skip to next dialogue line (debug)
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
#		$DialogueBox._on_balloon_gui_input(event)
		pass

func set_movement_mode(new_mode: MODES, mouse_mode := Input.MOUSE_MODE_CAPTURED):
	previous_mode = current_mode
	current_mode = new_mode
	Input.mouse_mode = mouse_mode

func look_at_object(object_path: String):
	var object = get_tree().get_root().get_node(object_path)
	var target_position = object.global_position
	
#Workaround for getting look at camera rotation
	var old_rotation = camera3D.rotation
	camera3D.look_at(target_position)
	var look_at_rotation = camera3D.rotation
	camera3D.rotation = old_rotation
	
	var tween = get_tree().create_tween()
	tween.tween_property(camera3D,"rotation", look_at_rotation, .3)
	tween.play()
