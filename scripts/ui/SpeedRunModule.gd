extends Control

var is_speedrun: bool
var elapsed_time: float = 0.0
@export var is_running: bool = false

var mins_hours_label: Label
var mili_label: Label

func _ready():
	mins_hours_label = $MinsHours
	mili_label = $Mili
	if is_speedrun:
		start_timer()

func _process(delta: float) -> void:
	if is_running:
		elapsed_time += delta
		update_timer_display()

func start_timer() -> void:
	is_running = true

func stop_timer() -> void:
	is_running = false

func reset_timer() -> void:
	is_running = false
	elapsed_time = 0.0
	update_timer_display()

func update_timer_display() -> void:
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	var milliseconds = int((elapsed_time - int(elapsed_time)) * 100)
	mins_hours_label.text = "%02d:%02d" % [minutes, seconds]
	mili_label.text = ".%02d" % [milliseconds]
