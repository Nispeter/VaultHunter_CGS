extends Node

var screen_stack: Array = []
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func open_screen(screen: Screen) -> void:
	_clear_stack()
	_push_screen(screen)
	

func open_on_top(screen: Screen) -> void:
	_push_screen(screen)

func back() -> void:
	if screen_stack.size() > 0:
		_pop_screen()

func exit() -> void:
	_clear_stack()

func exit_to_game() -> void:
	while screen_stack.size() > 1:
		_pop_screen()

func _push_screen(screen: Screen) -> void:
	if screen_stack.size() > 0:
		var current_screen = screen_stack.back()
		current_screen.deactivate()
	screen_stack.append(screen)
	#add_child(screen) 
	screen.activate()  

func _pop_screen() -> void:
	if screen_stack.size() == 0:
		return
	var current_screen = screen_stack.pop_back()
	current_screen.deactivate()  
	if screen_stack.size() > 0:
		var previous_screen = screen_stack.back()
		previous_screen.activate()  

func _clear_stack() -> void:
	while screen_stack.size() > 0:
		_pop_screen()

func _is_playing() -> bool:
	return screen_stack.is_empty()
