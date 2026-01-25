extends Level

@onready var pause_menu: Node2D = %PauseMenu

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_game"):
		if pause_menu.has_method("pause_game"):
			pause_menu.pause_game()
