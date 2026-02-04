class_name LevelArea extends Node2D

@export var info: Dictionary = {
	"scene": null,
	"level_nickname": "Default",
	"rating": 0,
}

func display() -> void:
	Events.level_selected.emit(info)
