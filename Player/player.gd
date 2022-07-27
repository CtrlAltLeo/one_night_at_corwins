extends KinematicBody

var do_heartbeat = false

var frozen = false

var noise_level = 0

var speed = 14

var sanity = 100

var flashlight_level = 100
var flashlight_noise_level = 0
var flashlight_active = true
var flashlight_ping = false

var hiding = false

var holding_object = false

var viewed_object = null

var mouse_sense = .2

signal share_cam_pos(pos, rot)
signal share_pos(pos)
signal make_soft_noise(pos)
signal make_loud_noise(pos)

signal light_on
signal light_off

signal init_interact

signal hide
signal unhide

signal test

signal player_caught

var paused = false
signal pause
signal unpause

onready var interactRaycast = $Camera/interact
onready var camera = $Camera

func _ready():
	
	
	mouse_sense = Globals.mouse_sense
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	do_heartbeat = Globals.spencer_mode
	
	if do_heartbeat == false:
		$Control/RichTextLabel.hide()
		
	if do_heartbeat:
		$flashlight_battery.wait_time = 3
	
func _input(event):
	
	if frozen:
		return
	
	if event is InputEventMouseMotion:

		rotation_degrees.y -= event.relative.x * mouse_sense
		
		var movementY = camera.rotation_degrees.x - event.relative.y * mouse_sense
		
		if movementY > 130: #if mouse movement is greater or less than the caps, make it the 
			camera.rotation_degrees.x = 130  #greatest or least.
		elif movementY < -100:
			camera.rotation_degrees.x = -100
		else:
			camera.rotation_degrees.x -= event.relative.y * mouse_sense
		
		
		
	
func _process(delta):
	
	$Control/RichTextLabel.text = str(sanity)
	
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_key_pressed(KEY_ENTER):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	#get_interaction_object()
	
	if Input.is_action_just_pressed("E"):
		interact()
		
	if Input.is_action_just_pressed("F"):
		print(flashlight_noise_level)
		charge_flashlight()
		
	if Input.is_action_just_pressed("R"):
		
		$flashglith.play()
		if flashlight_active:
			flashlight_off()
		else:
			flashlight_on()
			
	if Input.is_action_just_pressed("TAB"):
		if paused:
			paused = false
			emit_signal("unpause")
			unfreeze()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			paused = true
			emit_signal("pause")
			freeze()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _physics_process(delta):
	
	if frozen:
		return
	
	move_player()
	

func move_player():
	
	var direction = Vector3()
	
	direction.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	direction.z = Input.get_action_strength("S") - Input.get_action_strength("W")
	
	direction = direction.rotated(Vector3(0,1,0), rotation.y)
	
	direction = direction.normalized()
	
	move_and_slide(direction * speed)
	
	if direction != Vector3():
		share_cords()
		
		
	
func get_interaction_object():
	var col = interactRaycast.get_collider()
	
	if col == null:
		
		if viewed_object != null:
			disconnect("init_interact", get_node(viewed_object), "interact")
			viewed_object = null
		return
		
	if is_connected("init_interact", col.get_parent(),"interact"):
		return
	
	connect("init_interact", col.get_parent(), "interact")
	viewed_object = get_path_to(col.get_parent())
	
func interact():
#	print("click")
	get_interaction_object()

	emit_signal("init_interact")
	
	if viewed_object != null:
		disconnect("init_interact", get_node(viewed_object), "interact")
		viewed_object = null

	
	
func throw_object():
	pass
	
func die():
	pass
	
func sprint():
	pass
	
func make_noise():
	pass
	
func hide_player():
	print("hiding player")
	hiding = true
	emit_signal("hide")

func show_player():
	print("unhide player")
	hiding = false
	emit_signal("unhide")


func share_cords():
	emit_signal("share_pos", self.translation)
	
func share_cam_cords():
	emit_signal("share_cam_pos", camera.translation + self.translation, self.rotation.y)
	
func test():
	print("player")
	
func freeze():
	frozen = true
	$Camera/interact.enabled = false
	
func unfreeze():
	frozen = false
	$Camera/interact.enabled = true
	
func set_cam_current():
	camera.current = true
	
	
func charge_flashlight():
	
	$charge_sound_timeout.start(0)
	
	if $light_charge.playing == false:
		$light_charge.play()
		
	
	#flashlight_on()
	#flashlight_active = true
	
	flashlight_level += int(rand_range(5,10))
	
	if flashlight_level > 100:
		flashlight_level = 100
	
	flashlight_noise_level += 5
	
	if flashlight_noise_level > rand_range(20, 30) and !flashlight_ping:
		print("too loud!")
		$light_too_loud.play()
		emit_signal("make_loud_noise", translation)
		flashlight_ping = true
	
	if flashlight_active:
		$Camera/SpotLight.light_energy = flashlight_level * 0.03
	
func update_flashlight():
	$Camera/SpotLight.light_energy = flashlight_level * 0.03
	flashlight_level -= 5
	
	if flashlight_level < 0:
		flashlight_level = 0
			
	flashlight_noise_level -= 10
	
	if flashlight_noise_level < 0:
		flashlight_noise_level = 0
		
		
func flashlight_on():
	flashlight_active = true
	$Camera/SpotLight.light_energy = flashlight_level * 0.03
	emit_signal("light_on")
	$sanity_time.stop()
	
func flashlight_off():
	flashlight_active = false
	$Camera/SpotLight.light_energy = 0
	emit_signal("light_off")
	$sanity_time.start()

func player_speed_slow():
	speed = 6
	
func player_speed_fast():
	speed = 10




func _on_flashlight_battery_timeout():
	if flashlight_active:
		update_flashlight()
		flashlight_ping = false
		
		
func get_caught():
	freeze()
	print("they got me!")
	emit_signal("player_caught")
	
	
	


func _on_grab_hitbox_body_entered(body):
	
	if hiding:
		return
		
	
	if body.name == "chicken":
		get_caught()


func _on_sanity_time_timeout():
	
	if do_heartbeat == false:
		return
	
	sanity -= 1
	
	if sanity < 0:
		sanity = 0
	
	if flashlight_active == false:
		$sanity_time.start()
		

func do_sanity():
	
	if sanity < 50 and sanity >= 20:
		emit_signal("make_soft_noise", self.translation)
		
	if sanity < 20:
		$heartBeat.play()
		emit_signal("make_loud_noise", self.translation)
	

func _on_heartbeat_timer_timeout():
	do_sanity()
	
func get_sanity_back():
	sanity += 50
	if sanity > 100:
		sanity = 100


func _on_charge_sound_timeout_timeout():
	$light_charge.stop()
