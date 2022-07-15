extends KinematicBody

export var Nav = NodePath()

export (Array, NodePath) var preset_sentry_points
var found_sentry_points = []

var sentry_points = []

var speed = 7

var mode = 0 #patrol, goto, chase

var target = Vector3()
var path = []
var pathRank = 0

var player_pos = Vector3()

var player_view_distance = 60

var can_see_player = false

var player_hide = false

signal spot_player
signal at_goto
signal mode_change

func _ready():
	init_sentry_points()
	set_mode_sentry()

func _process(delta):
	$RichTextLabel.text = str(mode)
	
func do_modes():
	emit_signal("mode_change")
	
	disconnect("at_goto", self, "midchase_player_check")
	disconnect("at_goto", self, "set_mode_sentry")

	#patrol mode
	if mode == 0:
		set_speed_normal()
		connect("at_goto", self, "set_mode_sentry")
		$ai_tick.set_paused(false)
		$sentryMode.play()
		return
		
	#goto mode
	if mode == 1:
		set_speed_increasing()
		connect("at_goto", self, "set_mode_sentry")
		$ai_tick.set_paused(false)
		$gotoMode.play()
		return
	
	#chase mode
	if mode == 2:
		set_speed_increasing()
		connect("at_goto", self, "midchase_player_check")
		$ai_tick.set_paused(true)
		$chaseMode.play()
		return
	
	# wait mode
	if mode == 3:
		pass
		

func init_sentry_points():
	for sen in preset_sentry_points:
		sentry_points.append(get_node(sen).translation)
	
	
	
func _physics_process(delta):
	
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
	
	if pathRank + 1 == path.size():

		emit_signal("at_goto")
		return
		
	pathRank += 1
	
	
func update_target():
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
	
#	print(translation.distance_to(player_pos))
	
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
		set_mode_goto(player_pos)
		

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
	player_view_distance = 20
	
func playerview_big():
	player_view_distance = 60
	

func set_speed_normal():
	speed = 7
	
func set_speed_increasing():
	print("Faster faster!")
	speed *= 1.07
	

