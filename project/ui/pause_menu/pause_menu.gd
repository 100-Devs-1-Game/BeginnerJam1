extends Node2D

@onready var resume_button: Button = %ResumeButton
@onready var settings_button: Button = %SettingsButton
@onready var main_menu_button: Button = %MainMenuButton
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var resume_delay_timer: Timer = %ResumeDelayTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume_button.connect("pressed", resume_game)
	settings_button.connect("pressed", open_settings)
	main_menu_button.connect("pressed", return_to_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if resume_delay_timer.is_stopped():
		if Input.is_action_just_pressed("pause_game"):
			resume_game()

func pause_game() -> void:
	canvas_layer.show()
	get_tree().paused = true
	resume_delay_timer.start()


func resume_game() -> void:
	canvas_layer.hide()
	get_tree().paused = false
	
func open_settings() -> void:
	pass

func return_to_main_menu() -> void:
	pass
