extends CanvasLayer

@onready var level_name: Label = $Control/MarginContainer/HBoxContainer/LevelName
@onready var rating_holder: HBoxContainer = $Control/MarginContainer/HBoxContainer/RatingDisplay/PanelContainer/HBoxContainer
@onready var play_button: Button = $Control/MarginContainer/HBoxContainer/PlayButton

var selected_level: PackedScene

func _ready() -> void:
	Events.level_selected.connect(_on_level_selected)
	play_button.pressed.connect(_on_play_button_pressed)
	hide()

func _on_level_selected(info_dict: Dictionary) -> void:
	show()
	play_button.grab_focus()
	level_name.text = info_dict["display_name"]
	selected_level = info_dict["level_scene"]
	
func _on_play_button_pressed() -> void:
	if selected_level:
		get_tree().change_scene_to_packed(selected_level)
	else:
		push_warning('No level loaded!')
