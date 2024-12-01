extends Node2D

@onready var bg_music : Node = $BgMusic
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelMusic.play_music_level()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
