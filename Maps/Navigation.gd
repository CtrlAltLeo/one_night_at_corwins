extends Navigation

signal give_path(path)

func get_path_to_(startpos, endpos):
	
	var path = []
	
	path = self.get_simple_path(startpos, endpos)

	return path
