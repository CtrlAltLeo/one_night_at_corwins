extends Spatial


var text_view = 0

var active_text = ""

var at_end = false

var spicy = false

signal text_over
signal new_text

func show_text():
	$can_see.start()
	
func hide_text():
	reset_box()


func new_message(text, spicy:=false):
	
	reset_box()
	
	active_text = text
	$Control/Label.text = active_text
	$text_show.wait_time = len(text) / 4
	$text_show.start()
	
	self.spicy = spicy
	
	show_text()
	
	emit_signal("new_text")
	

func reset_box():
	text_view = 0
	$Control/Label.visible_characters = 0
	at_end = false
	spicy = false
	
func check_end():
	
	if text_view == len(active_text):
		return true
		
	else:
		return false


func _on_text_show_timeout():
	hide_text()


func _on_can_see_timeout():
	text_view += 1
	$Control/Label.visible_characters = text_view
	
	if spicy:
		$Control/Label.uppercase = !$Control/Label.uppercase
	
	if check_end() == false:
		$can_see.start()
	else:
		emit_signal("text_over")
		
