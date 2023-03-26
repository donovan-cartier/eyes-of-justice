extends Control


@onready var balloon = $Balloon
var next_dialogue_res : DialogueResource
@onready var player : Player = get_parent()

func _ready():
	next_dialogue_res = load("res://dialogues/texts/testdialogue.dialogue")
	balloon.start(next_dialogue_res, "beginning")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.set_movement_mode(player.MODES.MOVE_NOT_ALLOWED)
