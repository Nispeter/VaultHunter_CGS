extends IHealth
class_name IBreakable

func die():
	get_parent().queue_free()
