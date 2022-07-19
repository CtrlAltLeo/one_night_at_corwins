extends "res://Scenes/interactable.gd"

export var key_id = -1

export (Texture) var texture

signal give_key(key, texture)





func _on_key_on_interact_success():
	inventory.give_key(key_id, texture)
	monolog.new_message("You got a key!")
	die()
