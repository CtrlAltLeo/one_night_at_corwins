extends Spatial

var keys = []
var key_textures = []

var parts = []

signal share_key_texts(array)


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
	share_key_textures()
	
	
func give_part(part):
	parts.append(part)
	
func take_key(key):
	keys.erase(key)
	
func take_part(part):
	parts.erase(part)
	

func print_inventory():
	print(keys)
	print(parts)
	

func share_key_textures():
	emit_signal("share_key_texts", key_textures)




