extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.level_selected.connect(_on_level_selected)

func _on_level_selected(info_dict: Dictionary) -> void:
	
