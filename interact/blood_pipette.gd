extends Area3D

var has_focus := false
var is_held := false
@onready var camera = get_tree().get_nodes_in_group("player")[0].get_node("CameraRoot/Camera3D")

func _on_mouse_entered():
	has_focus = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	has_focus = false
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton && event.is_pressed() && event.button_index == 1:
		is_held = !is_held
		print(is_held)

func _process(delta):
	if is_held:
		var position2D = get_viewport().get_mouse_position()
		var dropPlane  = Plane(Vector3(0, 1, 0), global_position.y)
		print(global_position.y)
		var position3D = dropPlane.intersects_ray(
		camera.project_ray_origin(position2D),
		camera.project_ray_normal(position2D))
		global_position = position3D
