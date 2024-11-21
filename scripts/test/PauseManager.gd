extends Node

@export var pause_menu: Control

func _ready():
	if pause_menu:
		pause_menu.visible = false

func _input(event):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false

	else:
		get_tree().paused = true
