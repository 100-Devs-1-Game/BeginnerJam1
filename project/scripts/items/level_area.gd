class_name LevelArea extends Node2D

@export var display_name: String = "Default"
var scene: PackedScene = null
var rating: int = 0
	
func display() -> void:
	var info: Dictionary = {
		"display_name": display_name,
		"scene": scene,
		"rating": rating
	}
	Events.level_selected.emit(info)
