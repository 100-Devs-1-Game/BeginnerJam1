extends Level


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file.call_deferred("uid://c2j6uhxqsv8fl")
