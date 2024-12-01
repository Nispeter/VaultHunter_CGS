extends Node

# Signals
signal new_game_started
signal level_restarted
signal score_saved

var high_score: int = 0
var save_file_path: String = "user://save_data.txt"
@onready var finish_menu: Screen = $"../UI2/FinishMenu"
@onready var time_counter: Node = $"../UI2/InGameUI/SpeedRunModule"
@onready var player: Node = $"../Player"

func _ready():
	new_game()

func new_game():
	if player:
		player.current_score = 0
		time_counter.elapsed_time = 0
		emit_signal("new_game_started")
		print("New game started!")
	else:
		print("Player not found!")

func restart_level():
	ScreenManager.back()
	if get_tree().current_scene:
		get_tree().reload_current_scene()
		emit_signal("level_restarted")
		print("Level restarted!")

func save_score():
	if player:
		var save_data = {
			"high_score": high_score,
			"last_score": player.current_score,
			"last_time": time_counter.elapsed_time
		}
		var file = FileAccess.open(save_file_path, FileAccess.WRITE)
		if file:
			file.store_string(JSON.new().stringify(save_data))
			file.close()
			emit_signal("score_saved")
			print("Score saved successfully!")
	else:
		print("Player not found! Cannot save score.")

func reset_scores():
	high_score = 0
	print("High score reset.")

func finish_game():
	if player:
		ScreenManager.open_on_top(finish_menu)
		save_score()
		emit_signal("game_finished")
		print("Game finished! Score:", player.current_score, "Time:", time_counter.elapsed_time)
	else:
		print("Player not found! Cannot finish game.")

func on_finish_area(body):
	if body.is_in_group("player"):
		finish_game()
