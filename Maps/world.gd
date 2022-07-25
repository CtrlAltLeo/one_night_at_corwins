extends Spatial


func _ready():
	spawn_parts()
	$key_and_part_randomizer.spawn_keys()

func spawn_keys():
	pass
	
func spawn_parts():
	$key_and_part_randomizer.spawn_parts()
