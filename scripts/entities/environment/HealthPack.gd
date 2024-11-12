extends ICollectible

@export var heal_value: int = 10
@export var float_speed: float = 1.0 
@export var float_amplitude: float = 10.0  

var original_y: float

func _ready():
	original_y = position.y  

func _process(delta: float) -> void:
	# position.y = original_y + sin(Time.get_ticks_msec() / 1000.0 * float_speed) * float_amplitude
	pass
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if body.has_node("HealthController"):
			var health_controller = body.get_node("HealthController")
			if health_controller.has_method("heal"):
				health_controller.heal(heal_value)
				print("healing "+ str(heal_value) +" points")
			queue_free()
