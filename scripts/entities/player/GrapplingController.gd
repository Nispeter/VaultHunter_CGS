extends Node2D

@onready var player_body: CharacterBody2D = $".."
@onready var raycast_angles: Node = $RayCast

var is_hooked: bool = false
var grapple_speed: float = 500.0
var grapple_max_distance: int = 500
var grapple_min_distance: int = 10
var grapple_current_distance: int
var hook_pos: Vector2 = Vector2.ZERO
var motion: Vector2 = Vector2.ZERO

func _ready() -> void:
	grapple_current_distance = grapple_max_distance

func _physics_process(delta: float) -> void:
	hook()

	if is_hooked:
		swing(delta)
		_draw()
		motion *= 0.975  # Swing damping
		player_body.velocity = motion
	else:
		motion = player_body.velocity

func _draw() -> void:
	if is_hooked:
		draw_line(Vector2(0, -16), to_local(hook_pos), Color.WHITE, 3, true)
	else:
		if raycast_angles is RayCast2D and raycast_angles.is_colliding():
			var collision_point = raycast_angles.get_collision_point()
			if global_position.distance_to(collision_point) < grapple_max_distance:
				draw_line(Vector2(0, -16), to_local(collision_point), Color.BLACK, 0.5, true)

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
			return raycast.get_collision_point()
	return Vector2.ZERO

func swing(delta: float) -> void:
	var radius: Vector2 = global_position - hook_pos
	if motion.length() < 0.01 or radius.length() < grapple_min_distance:
		return

	var angle: float = radius.angle_to(motion)
	var radial_velocity: float = cos(angle) * motion.length()
	motion = radius.normalized() * radial_velocity

	if global_position.distance_to(hook_pos) > grapple_current_distance:
		global_position = hook_pos + radius.normalized() * grapple_current_distance

	motion += (hook_pos - global_position).normalized() * 15000.0 * delta
