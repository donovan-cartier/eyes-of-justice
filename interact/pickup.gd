extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	match MissionManager.current_chapter:
		"chapter_1":
			print("hi")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

