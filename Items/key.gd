extends "res://Scenes/interactable.gd"

export var key_id = -1

signal give_key(key)



func _on_key_on_interact_success():
	inventory.give_key(key_id)
	monolog.new_message("You got a key!")
	die()
