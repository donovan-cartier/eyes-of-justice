extends Area3D

var has_focus := false
var is_held := false
@onready var camera = get_tree().get_nodes_in_group("player")[0].get_node("CameraRoot/Camera3D")

@onready var default_y_pos = global_position.y

var blood_drop = preload("res://interact/blood_drop.tscn")

func _on_mouse_entered():
	has_focus = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	has_focus = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton && event.is_pressed() && event.button_index == 1:
#		is_held = !is_held
		is_held = true
		if !is_held:
			global_position.y = default_y_pos

func _process(delta):
	if is_held:
		var position2D = get_viewport().get_mouse_position()
		var dropPlane  = Plane(Vector3(0, 1, 0), .9)
		var position3D = dropPlane.intersects_ray(
		camera.project_ray_origin(position2D),
		camera.project_ray_normal(position2D))
		global_position = position3D 

	if Input.is_action_just_pressed("action") && is_held:
		print('dropped')
		var blood_instance = blood_drop.instantiate()
		blood_instance.global_position = $DropSpawnPoint.global_position
		get_tree().get_root().get_node("World").add_child(blood_instance)
		
