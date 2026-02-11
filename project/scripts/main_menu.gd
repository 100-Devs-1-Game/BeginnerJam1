extends Level

@onready var level_areas: Node2D = %LevelAreas

func _ready() -> void:
	for i in GameManager.levels.size():
		level_areas.get_child(i).scene = GameManager.levels[i]

func _unhandled_key_input(_event: InputEvent) -> void:
	pass
