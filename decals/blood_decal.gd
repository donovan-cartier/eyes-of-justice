extends Decal

@onready var desk_evidence = get_tree().get_nodes_in_group("desk_evidence")[0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body == desk_evidence:
		desk_evidence.get_parent().add_blood_drop()
