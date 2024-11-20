extends Screen

func _ready():
	ScreenManager.open_on_top(self)

func button_press():
	ScreenManager.back()
