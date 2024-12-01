extends CharacterBody2D

@export var spawn_point: Node

var health_controller : Node
var movement_controller : Node
var grappling_controller : Node
var booster_manager : Node

@export var live_counter : Label
@export var score_counter : Label
@export var max_lives : int

@onready var coin_sfx : Node = $CoinSfx
@onready var boost_sfx : Node = $BoostSfx
var current_lives : int
var current_score : int

func _ready():
	
	health_controller = $HealthController
	movement_controller = $MovementController
	grappling_controller = $GrapplingController
	booster_manager = $BoosterManager
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
	coin_sfx.play()
	current_score += score_value
	score_counter.text = "score: " + str(current_score)

func _loose_live():
	current_lives -= 1
	live_counter.text = "LIVES: " + str(current_lives)
	if current_lives < 1:
		loose_game()
	else: spawn_player()
	
func activate_booster(type,duration):
	boost_sfx.play()
	booster_manager.activate_booster(type,duration)
	
func loose_game():
	print("you lost!")
	pass
	
