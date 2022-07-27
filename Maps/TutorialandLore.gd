extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$monologSystem.new_message("Use WASD to move.")


func _on_AudioStreamPlayer3D_finished():
	get_tree().change_scene("res://Maps/world.tscn")
	$player.flashlight_off()


func _on_textTripwire5_trip():
	$AudioStreamPlayer3D.play()
	
