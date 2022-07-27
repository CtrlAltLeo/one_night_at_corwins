extends Node2D


var text = ["Aodan was a diligent corwin worker.... always helped his co-workers, always there for his boss",
"... but... unfortunately... Aodan made one crucial mistake...", 
"well 3 actually... ",
"He arrived to work... LATE... on a Friday... 3 times in a row...",
"This has caused distress in the Corwin Admin, and Aodan will soon learn the hard way to NEVER show up late on a Friday..."]

var currentText = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$monologSystem.new_message(text[currentText])
	if Globals.tut_played:
		$skip.show()


func _on_monologSystem_text_over():
	currentText += 1
	
	if currentText > 4:
		get_tree().change_scene("res://Maps/TutorialandLore.tscn")
		return
	
	$monologSystem.new_message(text[currentText])
	
	
func _process(delta):
	
	if Input.is_action_just_pressed("TAB"):
		get_tree().change_scene("res://Maps/world.tscn")
		
