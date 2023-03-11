extends StaticBody3D

var pc_screen = load("res://ui/pc_interface.tscn")
var pc_started := false
var pc_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	if !pc_started:
		pc_instance = pc_screen.instantiate()
		get_tree().get_root().get_node("World").add_child(pc_instance)
		pc_started = true
	else:
		pc_instance.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
