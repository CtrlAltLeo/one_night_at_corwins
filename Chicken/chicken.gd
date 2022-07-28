extends KinematicBody

export var Nav = NodePath()

export (Array, NodePath) var preset_sentry_points
var found_sentry_points = []

var sentry_points = []

var speed = 10
var base_speed = 10

var mode = 0 #patrol, goto, chase

var target = Vector3()
var path = []
var pathRank = 0

var player_pos = Vector3()

var player_view_distance = 60

var can_see_player = false

var player_hide = false

var frozen = false

signal spot_player
signal at_goto
signal mode_change

signal catch_player

func _ready():
	self.translation = Vector3(69, 1, -62)
	
	init_sentry_points()
	set_mode_sentry()
	
	if Globals.spencer_mode:
		base_speed = 15
		speed = base_speed

func _process(delta):
	$RichTextLabel.text = str(mode)
	
func do_modes():
	
	if frozen:
		return
	
	emit_signal("mode_change")
	
	disconnect("at_goto", self, "midchase_player_check")
	disconnect("at_goto", self, "set_mode_wait")
	disconnect("at_goto", self, "set_mode_sentry")

	#patrol mode
	if mode == 0:
		
		$music.play("fade_out")
		
		set_speed_normal()
		connect("at_goto", self, "set_mode_wait")
		$ai_tick.set_paused(false)
		#$sentryMode.play()
		return
		
	#goto mode
	if mode == 1:
		set_speed_increasing()
		connect("at_goto", self, "set_mode_sentry")
		$ai_tick.set_paused(false)
		#$gotoMode.play()
		return
	
	#chase mode
	if mode == 2:
		set_speed_increasing()
		connect("at_goto", self, "midchase_player_check")
		$ai_tick.set_paused(true)
		$chaseMode.play()
		
		if $chase_music.playing == false:
			$music.play("fade_in")
			$chase_music.play()
		
		return
	
	# wait mode
	if mode == 3:
		$ai_tick.set_paused(false)
		
		

func init_sentry_points():
	for sen in preset_sentry_points:
		sentry_points.append(get_node(sen).translation)
	
	
	
func _physics_process(delta):
	
	if frozen:
		return
	
	move()
	
	

func move():
	

	var dir = target - self.translation
	dir = dir.normalized()
	dir.y = 0
	move_and_slide(dir * speed)
	
	if translation.distance_to(target) < .5:
		next_path()
		update_target()
	
	
func next_path():
	
	rotate_mesh()
	
	if pathRank + 1 == path.size():

		emit_signal("at_goto")
		return
		
	pathRank += 1
	
	
func update_target():
	
	if path.size() == 0:
		set_mode_sentry()
		return
	
	target = path[pathRank]


func set_view_player_target(pos):
	$view_player.cast_to = pos - translation
	
func update_player_pos(pos):
	
	player_pos = pos 
	

func set_mode(mode):
	self.mode = mode
	do_modes()
	
func get_mode():
	return mode
	
func set_target(pos):
	print("going to target!")
	make_new_path(pos)
	
func set_path(p):
	path = p
	pathRank = 0
	

func make_new_path(target):
	
	var new_path = get_node(Nav).get_path_to_(self.translation, target)
	set_path(new_path)
	update_target()
	

func _on_ai_tick_timeout():
	
	if do_player_check():
		emit_signal("spot_player")
	
	$ai_tick.start()



func set_mode_sentry():
	set_mode(0)
	
	var point_choice = int(rand_range(0,sentry_points.size()))
	
	var sentry_pos = sentry_points[point_choice]
	
	make_new_path(sentry_pos)
	
	
	
	
func set_mode_goto(pos):
	set_mode(1)
	
	make_new_path(pos)
	
	
	
func set_mode_chase():
	set_mode(2)
	make_new_path(player_pos)
	

func set_mode_wait():
	set_mode(3)
	$wait_timer.start()
	
	
	
#Try and combine thesee two functions
func do_player_check():
	
	var col = $view_player.get_collider()
	
	if col == null:
		return false
		
	if player_hide:
		return false

	if col.name == "player" and translation.distance_to(player_pos) <= player_view_distance:
		return true
	
	return false
		
		
func midchase_player_check():
	
	if do_player_check():
		emit_signal("spot_player")
	else:
		set_mode_wait()
		

func player_hiding():
	player_hide = true
	
func player_visible():
	player_hide = false
	

func add_sentry_point(pos):
	sentry_points.append(pos)
	#print(sentry_points.size())
	
func cleanup_sentry_points():
	
	sentry_points.remove(int(rand_range(0, sentry_points.size())))
	

func playerview_small():
	player_view_distance = 15
	
func playerview_big():
	player_view_distance = 60
	

func set_speed_normal():
	speed = base_speed
	
func set_speed_increasing():
	print("Faster faster!")
	speed *= 1.07
	

func on_player_death():
	
	queue_free()
	
	
func freeze():
	frozen = true
	
func unfreeze():
	frozen = false


func rotate_mesh():
	var velocity = target - translation
	
	var lookdir = atan2(velocity.x, velocity.z)
	$chickenV2.rotation.y = lookdir


func _on_wait_timer_timeout():
	set_mode_sentry()


func _on_Area_area_entered(area): #Door is area
	if area.name == "chicken_rebuff":
		print("stuck")
		set_mode_sentry()
#		var point_choice = int(rand_range(0,sentry_points.size()))
#
#		var sentry_pos = sentry_points[point_choice]
#		self.translation = Vector3(sentry_pos.x, self.translation.y, sentry_pos.z)
		



func _on_music_animation_finished(anim_name):
	
	if anim_name == "fade_out":
		$chase_music.stop()


func _on_frick_you_hunting_timeout():
	set_mode_goto(player_pos)
