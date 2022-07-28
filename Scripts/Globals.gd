extends Node


var mouse_sense = .2
var spencer_mode = false


var lore_points = 0

var tut_played = false

func _restart_level():
	
	get_tree().change_scene("res://Scenes/PointerScne.tscn")
