extends CharacterBody2D

@export var spawn_point: Node

var health_controller : Node
var movement_controller : Node
var grappling_controller : Node

@export var live_counter : Label
@export var score_counter : Label
@export var max_lives : int
var current_lives : int
var current_score : int

func _ready():
	health_controller = $HealthController
	movement_controller = $MovementController
	grappling_controller = $GrapplingController
	new_game()
	
func new_game():
	health_controller.new_game()
	spawn_player()
	current_lives = max_lives
	current_score = 0
	live_counter.text = "LIVES: " + str(current_lives)

func spawn_player():
	if spawn_point:
		position = spawn_point.position
	pass
	
func add_score(score_value: int):
	current_score += score_value
	score_counter.text = "score: " + str(current_score)

func _loose_live():
	current_lives -= 1
	live_counter.text = "LIVES: " + str(current_lives)
	if current_lives < 1:
		loose_game()
	else: spawn_player()
	
func loose_game():
	print("you lost!")
	pass
	
#TODO: change enum values (int) to match the correct booster in a string (for legibility) 
#ALERT: this breakes the single responsability principle, but i think there is no better place to put it (yet)
func activate_booster(booster: int, duration:int) -> void:
	match booster:
		0:
			print("Speed Booster Activated!")
			movement_controller.speed *= 1.5
			await delay(duration)
			movement_controller.speed /= 1.5
		1:
			print("Grapple Hook Activated!")
			grappling_controller.is_active = true
			await delay(duration)
			grappling_controller.is_active = false
		2:
			print("Jump Booster Activated!")
			movement_controller.max_jumps += 1
			await delay(duration)
			movement_controller.max_jumps -= 1
	
	
func delay(seconds: int) -> void:
	await get_tree().create_timer(seconds).timeout
