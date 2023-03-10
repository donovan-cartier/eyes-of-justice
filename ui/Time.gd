extends Label

var current_time

# Called when the node enters the scene tree for the first time.
func _ready():
	update_time()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_time()

func update_time():
	current_time = Time.get_time_dict_from_system()
	text = str(current_time.hour) + ":" + str(current_time.minute)
