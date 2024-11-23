extends Node2D

@onready var player_body: CharacterBody2D = $".."
@onready var raycast_angles: Node = $RayCast

@export var is_active: bool = false
var is_hooked: bool = false
var grapple_speed: float = 400.0
var swing_damping = 0.9
var grapple_max_distance: int = 200
var grapple_min_distance: int = 4
var grapple_current_distance: int
var hook_pos: Vector2 = Vector2.ZERO
var motion: Vector2 = Vector2.ZERO
func _ready() -> void:
	grapple_current_distance = grapple_max_distance

func _physics_process(delta: float) -> void:
	if is_active == false: return 		
	hook()
	queue_redraw()						#TODO: search a better method for drawing a hook, like texture tiling
	if is_hooked:
		swing(delta)
		motion -= motion.project((hook_pos - global_position).normalized()) * (1 - swing_damping)
		player_body.velocity = motion
	else:
		motion = player_body.velocity

func _draw() -> void:
	if is_hooked:
		#print("drawing line")
		draw_line(Vector2(4,0), to_local(hook_pos), Color.WHITE, 3, true)
	else:
		if raycast_angles is RayCast2D and raycast_angles.is_colliding():
			var collision_point = raycast_angles.get_collision_point()
			if global_position.distance_to(collision_point) < grapple_max_distance:
				draw_line(Vector2(4,0), to_local(collision_point), Color.BLACK, 0.5, true)

func hook() -> void:
	raycast_angles.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		var new_hook_pos = get_hook_pos()
		if new_hook_pos:
			hook_pos = new_hook_pos
			is_hooked = true
			grapple_current_distance = global_position.distance_to(hook_pos)
	
	if Input.is_action_just_released("grapple") and is_hooked:
		is_hooked = false

func get_hook_pos() -> Vector2:
	for raycast in raycast_angles.get_children():
		if raycast is RayCast2D and raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider and not collider.is_in_group("Player"):
				return raycast.get_collision_point()
	return Vector2.ZERO

#TODO: horizontal momentum missing on hook release and swing
func swing(delta: float) -> void: 
	var radius: Vector2 = global_position - hook_pos
	if motion.length() < 0.01 or radius.length() < grapple_min_distance:
		return

	var angle: float = acos(radius.dot(motion))/(radius.length() * motion.length())
	var radial_velocity: float = cos(angle) * motion.length()
	motion = radius.normalized() * -radial_velocity

	if global_position.distance_to(hook_pos) > grapple_current_distance:
		player_body.global_position = hook_pos + radius.normalized() * grapple_current_distance

	motion += (hook_pos - global_position).normalized() * 15000.0 * delta
