extends CanvasLayer

@onready var level_name: Label = $Control/MarginContainer/HBoxContainer/LevelName
@onready var rating_holder: HBoxContainer = $Control/MarginContainer/HBoxContainer/RatingDisplay/PanelContainer/HBoxContainer
@onready var play_button: Button = $Control/MarginContainer/HBoxContainer/PlayButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.level_selected.connect(_on_level_selected)
	hide()

func _on_level_selected(_info_dict: Dictionary) -> void:
	show()
	play_button.grab_focus()
