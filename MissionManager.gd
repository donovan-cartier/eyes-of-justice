extends Node


var mission_list_path = "res://missions.json"
var mission_list

var current_chapter
var current_mission


@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var hud_mission_title = player.get_node("Player_HUD/Missions/MissionTitle")
@onready var hud_mission_objective = player.get_node("Player_HUD/Missions/MissionObjective")

func _ready():
	load_mission_list_by_chapter("chapter_1")
	set_current_mission_by_id(0)
	print(current_mission)

func load_mission_list_by_chapter(chapter_name: String):
	var file = FileAccess.open(mission_list_path, FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	mission_list = json_object.get_data().chapters[0][chapter_name].missions
	set_current_chapter(chapter_name)

func get_current_mission():
	return current_mission

func set_current_mission_by_id(id: int):
	current_mission = mission_list[id]
	update_hud()

func set_current_mission_to_next():
	current_mission = mission_list[current_mission.id + 1]
	update_hud()

func is_in_mission():
	pass

func update_hud():
	hud_mission_title.text = current_mission.mission_title
	hud_mission_objective.text = current_mission.mission_objective

func set_current_chapter(chapter_name: String):
	current_chapter = chapter_name
