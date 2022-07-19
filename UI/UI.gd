extends Control

signal quit_to_start
signal restart

var key_textures = []



func open_pause_menu():
	
	for t in key_textures:
		print(t)
		
		var text = TextureRect.new()
		text.texture = t
		$pause_menu/key_items.add_child(text)
	
	$pause_menu.show()
	
func close_pause_menu():
	
	for c in $pause_menu/key_items.get_children():
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
	

	


func _on_Inventory_share_key_texts(array):
	key_textures = array
	print(key_textures)
