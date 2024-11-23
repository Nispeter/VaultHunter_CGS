class_name Booster
extends ICollectible

enum BoosterType { SPEED, GRAPPLE, JUMP, SHRINK }
@export var type: BoosterType = BoosterType.SPEED
@export var duration: int = 10

func _ready() -> void:
	hint_string = "Pick up Booster"

func collect(body: Node):
	if body.has_method("activate_booster"):
		body.activate_booster(type, duration)
