extends "res://Scenes/interactable.gd"


export (Color) var door_color


export var key_id = 0

func _ready():
	
	$MeshInstance.get_surface_material(0).albedo_color = door_color

func _on_door_on_interact_success():
	
	if key_id > 0:
		if inventory.has_key(key_id):
			queue_free()
		else:
			noise_maker_path.make_loud_noise(self.translation)
			monolog.new_message("You don't have the right key!")
			
	else:
		queue_free()
			
