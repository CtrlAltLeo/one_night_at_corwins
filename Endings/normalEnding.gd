extends Node2D

export var words = "words1"


func _ready():
	
	$AnimationPlayer.play("carMove")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "carMove":
		$AnimationPlayer.play(words)
		
	if anim_name == words:
		get_tree().change_scene("res://UI/main_menu.tscn")
