class_name Screen
extends Control  

#NOTE: this class should work as a base for all screens in game 

func activate() -> void:
	self.visible = true
	on_activate()

func deactivate() -> void:
	self.visible = false
	on_deactivate()

func on_activate() -> void:
	pass

func on_deactivate() -> void:
	pass
