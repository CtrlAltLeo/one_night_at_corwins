extends Spatial

var part_textures = ["res://UI/icons/hubCap.png","res://UI/icons/muffler.png","res://UI/icons/piston.png"]
var part_names = ["hubcap", "muffler", "piston"]

export (Array, Texture) var key_textures
var key_names = ["key_green", "key_yellow", "key_red", "key_blue", "key_purple"]
					
var part = load("res://Items/part.tscn")
var key = load("res://Items/key.tscn")


	
func spawn_parts():
	for i in range(3):
		
		var pos = $part_spawns.get_child(int(rand_range(0, $part_spawns.get_child_count())))
		
		var new_part = part.instance()
		new_part.part_name = part_names[i]
		new_part.part_texture = part_textures[i]
		new_part.translation = pos.translation
		print(i)

		get_parent().add_child(new_part)
		
func spawn_keys():
	for i in range(5):
		
		
		var node = get_node(key_names[i])
		var pos = node.get_child(int(rand_range(0, node.get_child_count())))
		
		
		var new_key = key.instance()
		new_key.key_id = i + 1
		new_key.texture = key_textures[i]
		new_key.translation = pos.translation
		
		get_parent().add_child(new_key)
		
		
		
		
