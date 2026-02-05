class_name LevelArea extends Node2D

@export var level_scene: PackedScene
@export var display_name: String = "Default"
var rating: int = 0

func _ready() -> void:
	print(level_scene)
	
func display() -> void:
	var info: Dictionary = {
		"level_scene": level_scene,
		"display_name": display_name,
		"rating": rating
	}
	Events.level_selected.emit(info)
