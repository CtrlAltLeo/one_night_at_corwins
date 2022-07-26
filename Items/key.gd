extends "res://Scenes/interactable.gd"

export var key_id = -1

export (Texture) var texture

signal give_key(key, texture)

export (Array, Color) var colors



func _ready():
	$items/Cylinder003.get_surface_material(0).albedo_color = colors[key_id - 1]



func _on_key_on_interact_success():
	#noise_maker_path.make_loud_noise(self.translation)
	inventory.give_key(key_id, texture)
	monolog.new_message("You got a key!")
	die()
