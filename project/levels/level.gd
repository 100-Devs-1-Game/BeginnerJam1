class_name Level
extends Node2D

#region onready variables

@onready var tile_map_layer: TileMapLayer = %TileMapLayer
@onready var pause_menu: PauseMenu = %PauseMenu

#endregion

#region virtual methods

func _ready() -> void:
	Map._tilemap = tile_map_layer


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_game"):
		pause_menu.pause_game()

#endregion
