extends Spatial


func restart_scene():
	
	Globals._restart_level()
	
	#get_tree().change_scene("res://Maps/world.tscn")
	

func quit_to_scene():
	get_tree().change_scene("res://UI/main_menu.tscn")



