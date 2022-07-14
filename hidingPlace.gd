extends "res://Scenes/interactable.gd"

var player_hiding = false

signal hide_player

signal unhide_player


func _on_hidingPlace_on_interact_success():
	
	if player_hiding == true:
		unhide()
		return
	
	if player_hiding == false:	
		player_path.connect("share_cam_pos", self, "move_cam_to_player")
		
		
		#This will freeze and hide the payer, and share their cords
		connect("hide_player", player_path, "freeze")
		connect("hide_player", player_path, "hide_player")
		connect("hide_player", player_path, "share_cam_cords")
		
		#connects unhide to unfreeze
		connect("unhide_player", player_path, "set_cam_current")
		connect("unhide_player", player_path, "unfreeze")
		connect("unhide_player", player_path, "show_player")
		
		emit_signal("hide_player")
		return

func move_cam_to_player(pos,rot):
	
	
	$Camera.translation = pos
	$Camera.rotation.y = rot #+ PI
	
	$Camera.current = true
	
	print("tweening!")
	
	player_hiding = true
	
	#tween shizzle
	$Tween.interpolate_property($Camera, "translation", pos, $hidingZone.translation, 0.5,Tween.TRANS_LINEAR)
	$Tween.interpolate_property($Camera, "rotation", Vector3(rotation.x,rot,rotation.y), Vector3(rotation.x, rot + PI, rotation.z) , 0.5,Tween.TRANS_LINEAR)
	
	$Tween.start()
	
func unhide():
	$Camera.current = false
	emit_signal("unhide_player")
	
	player_path.disconnect("share_cam_pos", self, "move_cam_to_player")
	
	player_hiding = false
	
	
	
