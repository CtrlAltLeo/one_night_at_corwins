extends "res://Scenes/interactable.gd"

export var part_id = -1

signal give_part(p)

func _on_part_on_interact_success():
	emit_signal("give_part", part_id)
	die()
