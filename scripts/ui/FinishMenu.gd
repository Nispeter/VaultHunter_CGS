extends Screen

@onready var high_score_label: Label = $Label
@onready var best_time_label: Label = $Label2

var save_file_path: String = "user://save_data.txt"

# Variables for high scores
var high_score: int = 0
var best_time: float = 0.0

func on_activate() -> void:
	load_scores()

	high_score_label.text = "High Score: %d" % high_score
	best_time_label.text = "Best Time: %.2f seconds" % best_time

	visible = true

func load_scores() -> void:
	var save_data = load_file()

	if save_data:
		var lines = save_data.split("\n")
		if lines.size() >= 2:
			high_score = int(lines[0])
			best_time = float(lines[1])

	print("Loaded High Score:", high_score)
	print("Loaded Best Time:", best_time)

func load_file() -> String:
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			return content
		else:
			print("Failed to open file for reading.")
	else:
		print("Save file does not exist.")

	return ""
