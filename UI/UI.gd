extends Control

signal quit_to_start
signal restart

var key_textures = []
var part_textures = []



func open_pause_menu():
	
	for t in key_textures:
		print(t)
		
		var text = TextureRect.new()
		text.texture = t
		$pause_menu/key_items.add_child(text)
		
	for p in part_textures:
		var text = TextureRect.new()
		text.texture = load(p)
		$pause_menu/part_items.add_child(text)
	
	$pause_menu.show()
	
func close_pause_menu():
	
	for c in $pause_menu/key_items.get_children():
		c.queue_free()
		
	for c in $pause_menu/part_items.get_children():
		c.queue_free()
	
	$pause_menu.hide()
	

func game_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$game_over.show()
	


func _on_tryagain_pressed():
	print("restart")
	emit_signal("restart")


func _on_quit_pressed():
	print("quit")
	emit_signal("quit_to_start")
	

	

func get_inventory_info(key_text, part_text):
	key_textures = key_text
	part_textures = part_text


