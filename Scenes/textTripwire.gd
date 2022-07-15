extends Spatial


var triggered = false

signal text_wire(text, spicy)

export(String) var text
export var spicy = false


func _on_Area_body_entered(body):
	if body.name == "player":
		
		if triggered:
			return
		
		emit_signal("text_wire", text, spicy)
		triggered = true
