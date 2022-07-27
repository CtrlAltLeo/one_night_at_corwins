extends Spatial

var player_path = ""
var noise_maker_path = ""
var inventory = ""
var monolog = ""

var queue_to_die = false

signal make_noise(pos)
signal share_pos(pos)

signal on_interact_success

func _ready():
	
	if get_parent() == null:
		return
	
	player_path = get_parent().get_node("player")
	noise_maker_path = get_parent().get_node("NoiseSystem")
	inventory = get_parent().get_node("Inventory")
	monolog = get_parent().get_node("monologSystem")

func _process(delta):
	pass

func interact():
	print("Player interacted with " + self.name +"!" )
	emit_signal("on_interact_success")
	
	
func raycast_entered():
	pass
	
func raycast_exited():
	pass
	

func die():
	if $FX.playing:
		queue_to_die = true
		self.hide()
		
	else:
		queue_free()




func _on_FX_finished():
	if queue_to_die:
		
		queue_free()
