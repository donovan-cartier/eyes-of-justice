extends StaticBody3D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var player_camera = player.get_node("CameraRoot")
@onready var camera_point = $CameraPoint

@export var item_to_place : String

var saved_camera_location : Vector3
var saved_camera_rotation : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	#Stop player movement
	player.set_movement_mode(player.MODES.MOVE_NOT_ALLOWED)
	
	#Save camera transform to restore later
	saved_camera_location = player_camera.global_position
	saved_camera_rotation = player_camera.global_rotation
	#Move camera to $CameraPoint location
	player_camera.global_rotation = camera_point.global_rotation
	player_camera.global_position = camera_point.global_position
	
	#Disable interaction
	remove_from_group("interact")
	
	$DeskInterface.start()

func stop_interact():
	#Give player movement back
	player.set_movement_mode(player.MODES.FULL_MOVEMENT)
	
	#Move camera to original location
	player_camera.global_rotation = saved_camera_rotation
	player_camera.global_position = saved_camera_location
	
	#Enable interaction
	add_to_group("interact")

#"Place" evidence item (will have to change mesh according to evidence mesh)
func _on_place_item_pressed():
	$EvidenceMesh.show()
	if MissionManager.current_chapter == "chapter_1" && MissionManager.current_mission.id == 1:
		MissionManager.set_current_mission_to_next()
