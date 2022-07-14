extends Spatial


var noises = []

signal new_soft_noise(pos)
signal new_loud_noise(pos)

func make_soft_noise(pos):
	emit_signal("new_soft_noise", pos)
	
func make_loud_noise(pos):
	print("Loud noise!")
	emit_signal("new_loud_noise", pos)
