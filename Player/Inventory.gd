extends Spatial

var keys = []
var key_textures = []

var parts = []
var part_textures = []

signal give_info(key_textures, part_textures)


func has_key(key_id):
	
	if keys.has(key_id):
		return true
	
	return false
	
func has_part(part_id):
	if parts.has(part_id):
		return true
		
	return false
	
func give_key(key, texture):
	keys.append(key)
	key_textures.append(texture)
	print("Got key " + str(key))
	give_ui_info()
	
	
func give_part(part, texture):
	parts.append(part)
	part_textures.append(texture)
	give_ui_info()
	
func take_key(key):
	keys.erase(key)
	
func take_part(part):
	parts.erase(part)
	

func print_inventory():
	print(keys)
	print(parts)
	

func get_parts():
	
	return "parts"
	

func give_ui_info():
	emit_signal("give_info", key_textures, part_textures)




