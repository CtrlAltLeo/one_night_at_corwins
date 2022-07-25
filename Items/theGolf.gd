extends "res://Scenes/interactable.gd"




func _on_theGolf_on_interact_success():
	
	if Globals.lore_points >= 8:
		get_tree().change_scene("lore_ending")
	
	if inventory.get_parts().size() == 3:
		get_tree().change_scene("res://Endings/normalEnding.tscn")
		return
		
	if "muffler" in inventory.get_parts() and "piston" in inventory.get_parts():
		get_tree().change_scene("res://Endings/no_hubcap.tscn")
		return
		
	if inventory.get_parts().size() == 0:
		monolog.new_message("You can't repair this yet!")
		monolog.new_message(str(Globals.lore_points))
	
	
	
#Check number of parts 
