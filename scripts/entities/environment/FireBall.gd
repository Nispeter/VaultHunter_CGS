extends IDamageDealer

@export var speed: float = 100.0  
@onready var path: Line2D = $Line2D 
var path_points: PackedVector2Array  
var current_index: int = 0  
var direction: int = 1 

func _ready():
	path_points = path.get_points()
	for i in range(path_points.size()):
		path_points[i] = path.to_global(path_points[i])
	global_position = path_points[0]

func _process(delta: float) -> void:
	follow_line(delta)

func follow_line(delta: float) -> void:
	if path_points.size() < 2:
		return 

	var target_point = path_points[current_index]
	var direction_vector = (target_point - global_position).normalized()
	var movement = direction_vector * speed * delta

	if movement.length() >= (target_point - global_position).length():
		global_position = target_point
		current_index += direction

		if current_index >= path_points.size() or current_index < 0:
			direction *= -1
			current_index = clamp(current_index, 0, path_points.size() - 1)
	else:
		global_position += movement
