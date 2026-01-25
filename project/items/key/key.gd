class_name Key
extends Node2D

@export var doorway: Node2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.area_entered.connect(_on_key_picked_up)


func _on_key_picked_up(_other_area: Area2D) -> void:
	# TODO Simplified solution implemented only for the purposes of the Start Menu
	doorway.hide()
	hide()
