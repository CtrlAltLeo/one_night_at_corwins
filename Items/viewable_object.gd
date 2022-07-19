extends "res://Scenes/interactable.gd"

export (Texture) var image setget set_texture
export (String) var view_text

func set_texture(t):
	
	print("arg")
	$Sprite3D.texture = t
	image = t
	
func _ready():
	$Sprite3D.texture = image



	


func _on_viewable_object_on_interact_success():
	monolog.new_message(view_text)
