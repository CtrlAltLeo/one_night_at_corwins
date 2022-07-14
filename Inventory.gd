extends Spatial

var keys = []

var parts = []

func has_key(key_id):
	
	if keys.has(key_id):
		return true
	
	return false
	
func has_part(part_id):
	if parts.has(part_id):
		return true
		
	return false
	
func give_key(key):
	keys.append(key)
	print("Got key " + str(key))
	
func give_part(part):
	parts.append(part)
	
func take_key(key):
	keys.erase(key)
	
func take_part(part):
	parts.erase(part)
	

func print_inventory():
	print(keys)
	print(parts)

