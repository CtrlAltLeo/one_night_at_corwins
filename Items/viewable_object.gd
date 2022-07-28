extends "res://Scenes/interactable.gd"

tool

export var is_lore = false
var lore_used = false

export (Texture) var image setget set_texture
export (String) var view_text

func set_texture(t):
	print("arg")
	$Sprite3D.texture = t
	image = t
	
func _ready():
	$Sprite3D.texture = image
	
	
func _process(delta):
	
	if Engine.editor_hint:
		$Sprite3D.texture = image
		
	

func _on_viewable_object_on_interact_success():
	monolog.new_message(view_text)
	
	
	if is_lore and lore_used == false:
		lore_used = true
		Globals.lore_points += 1
		$FX.play()
