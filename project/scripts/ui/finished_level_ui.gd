extends CanvasLayer

@onready var next_level_button: Button = %NextLevel
@onready var play_again_button: Button = %PlayAgain
@onready var level_select_button: Button = %LevelSelect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.level_completed.connect(func(): show(); next_level_button.grab_focus())
	next_level_button.pressed.connect(_on_next_level_button_pressed)
	play_again_button.pressed.connect(_on_play_again_button_pressed)
	level_select_button.pressed.connect(_on_level_select_button_pressed)
	hide()


func _on_next_level_button_pressed() -> void:
	GameManager.next_level()
	

func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()
	
	
func _on_level_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
