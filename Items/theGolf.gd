extends "res://Scenes/interactable.gd"




func _on_theGolf_on_interact_success():
	
	if Globals.lore_points >= 6:
		get_tree().change_scene("res://Endings/lore_ending.tscn")
		return
	
	if inventory.get_parts().size() == 3:
		get_tree().change_scene("res://Endings/normalEnding.tscn")
		return
		
	if "muffler" in inventory.get_parts() and "piston" in inventory.get_parts():
		get_tree().change_scene("res://Endings/no_hubcap.tscn")
		return
		
	if inventory.get_parts().size() == 0:
		monolog.new_message("You can't repair this yet!")
		
	
	
	
#Check number of parts 
