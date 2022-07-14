extends "res://Scenes/interactable.gd"


var player_holding = false

var in_flight = false

var dir = Vector3()

func _ready():
	print(noise_maker_path.name)
	
	connect("make_noise", noise_maker_path, "make_loud_noise")
	
func _process(delta):
	
	if player_holding:
		var p = player_path
		
		translation = p.translation + Vector3(0,1.5,0) + Vector3(0,0,-2).rotated(Vector3(0,1,0),p.rotation.y)
		rotation.y = p.rotation.y
		
	if in_flight:
		translation += dir * .25
		dir.y -= .01
		
		for b in $hitbox.get_overlapping_bodies():
			in_flight = false
			emit_signal("make_noise", self.translation)
			print("making noise")


func _on_throwable_object_on_interact_success():
	
	if player_holding:
		
		throw()
	else:
		pickup()


func pickup():
	player_holding = true
	player_path.player_speed_slow()
	player_path.connect("init_interact", self, "throw")
	
func throw():
	player_holding = false
	player_path.player_speed_fast()
	player_path.disconnect("init_interact", self, "throw")
	
	dir =Vector3(0,0,-1).rotated(Vector3(1,0,0), player_path.camera.rotation.x) #+ Vector3(0,0,-1).rotated(Vector3(0,1,0), player_path.rotation.y) + 
	dir = dir.rotated(Vector3(0,1,0), player_path.rotation.y)
	in_flight = true
