extends Screen

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass

func button_press():
	ScreenManager.back()
	
func _on_pause():
	self.show()
	ScreenManager.open_on_top(self)
	get_tree().paused = true
	
func _on_unpause():
	self.hide()
	ScreenManager.back()
	get_tree().paused = false

func _input(event) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == true:
			self._on_unpause()
		else:
			self._on_pause()
			pass


func _on_resume_pressed() -> void:
	if get_tree().paused == true:
		self._on_unpause()
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	if get_tree().paused == true:
		self._on_unpause()
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	if get_tree().paused == true:
		self._on_unpause()
		get_tree().quit()
	pass # Replace with function body.
