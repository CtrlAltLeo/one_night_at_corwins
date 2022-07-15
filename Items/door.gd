extends "res://Scenes/interactable.gd"



export var key_id = 0

func _on_door_on_interact_success():
	
	if key_id > 0:
		if inventory.has_key(key_id):
			queue_free()
		else:
			monolog.new_message("You don't have the right key!")
			
	else:
		queue_free()
			
