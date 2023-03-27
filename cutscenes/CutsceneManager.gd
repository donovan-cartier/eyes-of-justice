extends Node

@onready var cutscene_manager = get_tree().get_root().get_node("World/CutsceneManager")

func play_cutscene(cutscene_name: String):
	cutscene_manager.play(cutscene_name)

func get_new_cutscene_manager():
	cutscene_manager = get_tree().get_root().get_node("World/CutsceneManager")
