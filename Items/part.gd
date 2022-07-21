extends "res://Scenes/interactable.gd"

export var part_id = -1

export var part_name = ""

export (Texture) var part_texture

signal give_part(p)

func _on_part_on_interact_success():
	inventory.give_part(part_name, part_texture)
	die()
