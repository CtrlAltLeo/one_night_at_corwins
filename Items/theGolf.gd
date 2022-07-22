extends "res://Scenes/interactable.gd"




func _on_theGolf_on_interact_success():
	
	monolog.new_message(inventory.get_parts())
