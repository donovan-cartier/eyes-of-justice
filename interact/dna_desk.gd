extends StaticBody3D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var player_camera = player.get_node("CameraRoot")
@onready var camera_point = $CameraPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	print('int desk')
	print("Global position of cameraRoot before: " + str(player_camera.global_position))
	print("Global position of camera3D before: " + str(player_camera.get_node("Camera3D").global_position))
	player.set_movement_mode(player.MODES.MOVE_NOT_ALLOWED)
	player_camera.global_rotation = camera_point.global_rotation
	player_camera.global_position = camera_point.global_position
	print("Global position of cameraRoot after: " + str(player_camera.global_position))
	print("Global position of camera3D after: " + str(player_camera.get_node("Camera3D").global_position))
	remove_from_group("interact")
