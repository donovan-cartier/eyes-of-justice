extends Node3D

#This node needs to be put in every object that is interactable

@onready var parent = get_parent()
@onready var player = get_tree().get_nodes_in_group("player")[0]

@onready var parent_default_transform = parent.global_transform 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Highlight an interactable object
func highlight():
#	print('highlight')
	if parent.get_node("MeshInstance3D"):
		parent.get_node("MeshInstance3D").get_active_material(0).next_pass.set_shader_parameter("outline_width", 2)
	
#Stop highlight
func stop_highlight():
#	print('highlight')
	if parent.get_node("MeshInstance3D"):
		parent.get_node("MeshInstance3D").get_active_material(0).next_pass.set_shader_parameter("outline_width", 0)
	
	
#Interact with the object
func interact():
	print('interact')
	stop_highlight()
	
	#Inspect object in 3D if has tag freelook
	if parent.is_in_group("freelook"):
		inspect()
	#Add object to inventory if has taf pickup
	elif parent.is_in_group("pickup"):
		player.get_node("Inventory").add_item(parent.name)
		parent.queue_free()
	#Else, use specific behavior for this object interaction
	else:
		parent.interact()
#	print(parent.global_transform.looking_at(player_object_anchor_pos).basis)
#	parent.global_transform.looking_at(player_object_anchor_pos).origin
	
#3D free inspection of the object
func inspect():
	var player_object_anchor_pos = player.get_node("CameraRoot/Camera3D/ObjectLookPoint").global_position
	var tween = create_tween()
	tween.tween_property(parent, "global_position", player_object_anchor_pos, .15)
#	tween.tween_property(parent, "global_rotation", , .15)
	parent.look_at(player_object_anchor_pos)
	player.inspect_object(parent)
	
#Stop 3D free inspection of the object
func stop_inspect():
	var tween = create_tween()
	tween.tween_property(parent, "global_transform", parent_default_transform, .15)

func disable_interaction():
	parent.remove_from_group("interact")
