extends "res://Scenes/interactable.gd"




func _on_food_on_interact_success():
	player_path.get_sanity_back()
	print(player_path.sanity)
	die()
