extends Spatial


var text_view = 0

var active_text = ""

var at_end = false

var spicy = false

onready var label = $Control/Label

signal text_over
signal new_text





func show_text():
	$can_see.start()
	
func hide_text():
	reset_box()
	label.queue_free()


func new_message(text, spicy:=false):
	
	reset_box()
	
	active_text = text
	label.text = active_text
	$text_show.wait_time = len(text) / 4
	$text_show.start()
	
	self.spicy = spicy
	
	show_text()
	
	emit_signal("new_text")
	

func reset_box():
	
	$Control.add_child(Label.new())
	
	label = $Control.get_child(0)
	
	edit_label()

	text_view = 0
	label.visible_characters = 0
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
	label.visible_characters = text_view
	
	if spicy:
		label.uppercase = !label.uppercase
	
	if check_end() == false:
		$can_see.start()
	else:
		emit_signal("text_over")
		
func edit_label():
	label.align = label.ALIGN_CENTER
	label.anchor_right = 1
	label.anchor_bottom = 1 
	label.theme = load("res://UI/aodanTHeme.tres")
	label.autowrap = true
		
