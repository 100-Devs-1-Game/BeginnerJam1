extends CanvasLayer

@onready var level_name: Label = $Control/MarginContainer/HBoxContainer/LevelName
@onready var rating_holder: HBoxContainer = $Control/MarginContainer/HBoxContainer/RatingDisplay/PanelContainer/HBoxContainer
@onready var play_button: Button = $Control/MarginContainer/HBoxContainer/PlayButton

var selected_level: PackedScene

func _ready() -> void:
	Events.level_selected.connect(_on_level_selected)
	Events.level_deselected.connect(_on_level_deselected)
	play_button.pressed.connect(_on_play_button_pressed)
	hide()

func _on_level_selected(info_dict: Dictionary) -> void:
	show()
	if info_dict["scene"] == null:
		play_button.hide()
		rating_holder.hide()
	else:
		play_button.show()
		rating_holder.show()
		play_button.grab_focus()
		selected_level = info_dict["scene"]
	level_name.text = info_dict["display_name"]
	
func _on_level_deselected() -> void:
	hide()
	
func _on_play_button_pressed() -> void:
	if selected_level:
		GameManager.play_level()
	else:
		push_warning('No level loaded!')
