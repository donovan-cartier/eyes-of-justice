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
	print('ready')

func load_mission_list_by_chapter(chapter_name: String):
	var file = FileAccess.open(mission_list_path, FileAccess.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(file.get_as_text())
	mission_list = json_object.get_data().chapters[0][chapter_name].missions
	print(hud_mission_title)
	refresh_nodes()
	print(hud_mission_title)
	set_current_chapter(chapter_name)

func get_current_mission():
	return current_mission

func set_current_mission_by_id(id: int):
	if mission_exists(id):
		current_mission = mission_list[id]
		update_hud()
	else:
		printerr("MISSION COULDN'T BE LOADED. Does it exists in missions.json?")

func set_current_mission_to_next():
	if mission_exists(current_mission.id + 1):
		current_mission = mission_list[current_mission.id + 1]
		update_hud()
	else:
		printerr("MISSION COULDN'T BE LOADED. Does it exists in missions.json?")

func is_in_mission():
	pass

func update_hud():
	hud_mission_title.text = current_mission.mission_title
	hud_mission_objective.text = current_mission.mission_objective
	print("updated_hud")
	print(current_mission)

func set_current_chapter(chapter_name: String):
	current_chapter = chapter_name

func mission_exists(id: int):
	return mission_list.size() > id

func refresh_nodes():
	player = get_tree().get_nodes_in_group("player")[0]
	hud_mission_title = player.get_node("Player_HUD/Missions/MissionTitle")
	hud_mission_objective = player.get_node("Player_HUD/Missions/MissionObjective")

#Do certain behaviors that need global context depending on the mission
func call_mission():
	if MissionManager.current_chapter == "chapter_1" && MissionManager.current_mission.id == 3:
		get_tree().change_scene_to_file("res://world.tscn")
		await get_tree().create_timer(.001).timeout
		MissionManager.load_mission_list_by_chapter("chapter_2")
		MissionManager.set_current_mission_by_id(0)
