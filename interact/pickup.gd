extends Area3D


func _exit_tree():
	match name:
		"CrimeEvidence_Sword":
			if MissionManager.current_chapter == "chapter_1" && MissionManager.current_mission.id == 0:
				MissionManager.set_current_mission_to_next()
		
