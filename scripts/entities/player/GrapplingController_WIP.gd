extends Node2D

@onready var player_body: CharacterBody2D = get_parent().player_body

var is_grappling:bool = false
var grapple_point:Vector2
var grapple_speed:float = 500
var grapple_max_distance:int = 500
var grapple_min_distance:int = 10

func _ready():
	player_body = $"../.."
	pass
	
func _handle_input():
	if Input.is_action_just_pressed("grapple"):
		print("grappling")
		start_grapple(get_global_mouse_position())
		
func start_grapple(target: Vector2):
	grapple_point = target
	is_grappling = true
	
func _physics_process(delta: float):
	_handle_input()
	if is_grappling:
		var direction = (grapple_point - player_body.global_position).normalized()
		player_body.position += direction * grapple_speed * delta
		
		if player_body.global_position.distance_to(grapple_point) < grapple_min_distance:
			stop_grapple()
			
func stop_grapple():
	is_grappling = false
	
# TODO: draw hook
#		pull till end
#		cancell pull
#		angular hook
