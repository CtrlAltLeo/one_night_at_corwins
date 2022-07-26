extends "res://Scenes/interactable.gd"

export var part_id = -1

export var part_name = ""

export (Texture) var part_texture

signal give_part(p)

func _ready():
	get_node(part_name).show()

func _on_part_on_interact_success():
	#noise_maker_path.make_loud_noise(self.translation)
	inventory.give_part(part_name, part_texture)
	die()
