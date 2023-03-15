extends Area3D

const fall_speed = 1.0
var blood_decal = preload("res://decals/blood_decal.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y -= fall_speed * delta

func _on_body_entered(body):
	var blood_instance = blood_decal.instantiate()
	blood_instance.global_position = global_position
	get_tree().get_root().get_node("World").add_child(blood_instance)
	queue_free()
