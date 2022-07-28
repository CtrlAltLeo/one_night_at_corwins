extends Spatial


func _ready():
	Globals.lore_points = 0
	spawn_parts()
	$key_and_part_randomizer.spawn_keys()

func spawn_keys():
	pass
	
func spawn_parts():
	$key_and_part_randomizer.spawn_parts()
	
	$Navigation/NavigationMeshInstance.navmesh.create_from_mesh($Navigation/NavigationMeshInstance/floor.mesh)
