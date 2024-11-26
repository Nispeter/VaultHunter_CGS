extends Line2D

@export var point_lenght = 50
var point_velocity = Vector2()

func _ready():
	top_level = true 

func _process(delta):

	point_velocity = get_parent().global_position
	add_point(point_velocity)
	while get_point_count() > point_lenght:
		remove_point(0)
		
