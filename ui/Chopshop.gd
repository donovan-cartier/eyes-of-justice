extends Window


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _on_close_requested():
	hide()

func _on_new_file_pressed():
	$Screen.show()
