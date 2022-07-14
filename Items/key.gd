extends "res://Scenes/interactable.gd"

export var key_id = -1

signal give_key(key)

func _ready():
	
	connect("on_interact_success", self, "get_key")
	
func get_key():
	
	emit_signal("give_key", key_id)
	die()
	

