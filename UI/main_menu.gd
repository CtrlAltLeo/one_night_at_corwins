extends Control




func _on_lightningTimer_timeout():
	$AnimationPlayer.play("lightnightStrike")
	$lightningTimer.wait_time = rand_range(1,4)


func _on_play_pressed():
	get_tree().change_scene("res://Maps/world.tscn")


func _on_options_pressed():
	$WindowDialog.popup_centered(Vector2(250,250))


func _on_quit_pressed():
	get_tree().quit()


func _on_LineEdit_text_changed(new_text):
	Globals.mouse_sense = int(new_text)


func _on_spencer_mode_toggled(button_pressed):
	Globals.spencer_mode = button_pressed
