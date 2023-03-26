extends Node

var emotion : String = "default"
var emotions : Dictionary = {"Zack": "default", "Nathan": "default"}

@onready var player := get_tree().get_nodes_in_group("player")[0]
