extends Area2D
class_name IDamageDealer

@export var damage_amount: int = 10
@export var target_object_id: int = 0

func deal_damage(target: Object) -> void: 
	if target.has_node("HealthController"):
		var health_controller = target.get_node("HealthController")
		print("dealing damage!")
		if health_controller.has_method("take_damage"):
			health_controller.take_damage(damage_amount)
		
func _on_body_entered(body: Node) -> void:
	deal_damage(body)
