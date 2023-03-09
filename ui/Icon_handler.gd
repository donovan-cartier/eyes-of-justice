extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	#Check for double click
	if event is InputEventMouseButton && event.is_double_click() && event.is_pressed() && event.button_index == 1:
		match self.name:
			"Chopshop":
				$"../../../ChopshopWindow".show()

func _on_mouse_entered():
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
