extends "res://Scenes/interactable.gd"


export var noise_pos = Vector3()

func _on_noiseMaker_on_interact_success():
	
	print("make noise")
	emit_signal("make_noise", noise_pos)
