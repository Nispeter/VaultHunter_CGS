extends IHealth

signal loose_lives
@onready var hit_sfx = $HitSfx
func die():
	current_health = 0
	loose_lives.emit()

func take_damage(damage: int) -> void:
	hit_sfx.play()
	current_health -= damage
	if current_health <= 0:
		die()
		
	print("damage taken: %d, current health: %d" %[damage, current_health])
