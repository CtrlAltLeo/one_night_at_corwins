extends Spatial


var triggered = false

signal text_wire(text, spicy)

var monolog = ""

export(String) var text
export var spicy = false

func _ready():
	$MeshInstance.queue_free()
	
	if get_parent() == null:
		return
	
	monolog = get_parent().get_node("monologSystem")
	


func _on_Area_body_entered(body):
	if body.name == "player":
		
		if triggered:
			return
		
		monolog.new_message(text, spicy)
		triggered = true
