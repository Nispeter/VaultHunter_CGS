class_name BoosterManager
extends Node2D

var player_body: Node2D

func _ready():
	player_body = get_parent()

#TODO: change enum values (int) to match the correct booster in a string (for legibility) 
#ALERT: this breakes the single responsability principle, but i think there is no better place to put it (yet)
func activate_booster(booster: int, duration:int) -> void:
	match booster:
		0:
			print_debug("Speed Booster Activated!")
			player_body.movement_controller.speed *= 1.5
			await delay(duration)
			player_body.movement_controller.speed /= 1.5
		1:
			print_debug("Grapple Hook Activated!")
			player_body.grappling_controller.is_active = true
			await delay(duration)
			player_body.grappling_controller.is_active = false
		2:
			print_debug("Jump Booster Activated!")
			player_body.movement_controller.max_jumps += 1
			await delay(duration)
			player_body.movement_controller.max_jumps -= 1
		3:
			#BUG: if hook daectivated while is active results on a bug
			print_debug("Shrink Booster Activated!")
			var start_scale = player_body.scale
			var target_scale = 0.5 * player_body.scale
			await shrink_player(target_scale, 1)  
			await delay(duration)
			await shrink_player(start_scale, 1)  
	
func delay(seconds: int) -> void:
	await get_tree().create_timer(seconds).timeout
	
func shrink_player(target_scale: Vector2, duration: float) -> void:
	var start_scale = player_body.scale
	var elapsed_time = 0.0
	while elapsed_time < duration:
		elapsed_time += get_process_delta_time()
		player_body.scale = start_scale.lerp(target_scale, elapsed_time / duration)
		await get_tree().process_frame
	player_body.scale = target_scale  
