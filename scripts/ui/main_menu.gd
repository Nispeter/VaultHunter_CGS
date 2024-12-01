extends Screen

@onready var start_level = preload("res://scenes/TestScene_DEV.tscn")
@onready var bg_music = $BackgroundMusic
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_music.play()
	ScreenManager.open_on_top(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	ScreenManager.back()


func _on_button_exit_pressed() -> void:
	ScreenManager.back()
	get_tree().quit()
