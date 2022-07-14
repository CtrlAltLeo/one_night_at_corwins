extends "res://Scenes/interactable.gd"


export var oneShot = true

var clicked = false

signal activate


func _on_button_on_interact_success():
	
	if oneShot:
		
		if clicked == false:
			emit_signal("activate")
			clicked = true
	
		return
		
	emit_signal("activate")
