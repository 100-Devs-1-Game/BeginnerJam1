extends Node2D

#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx_1: AudioStreamPlayer = $SFX1


func _on_area_2d_body_entered(body: Node2D) -> void:
	#audio_stream_player_2d.play()
	print("sound effect triggered")
	pass # Replace with function body.

func _on_area_entered(area: Area2D) -> void:
	sfx_1.play()
	print("sound effect triggered")

func _on_area_2d_area_entered(area: Player) -> void:
	#audio_stream_player_2d.play()
	sfx_1.play()
	print("sound effect triggered")
	pass # Replace with function body.


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sfx_1.play()
	pass # Replace with function body.
