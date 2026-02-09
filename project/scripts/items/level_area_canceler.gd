extends Node2D
	
func _ready() -> void:
	$Area2D.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var area_parent := area.get_parent()
	if area_parent.is_in_group("player"):
		area_parent.level_area = null
		Events.level_deselected.emit()
