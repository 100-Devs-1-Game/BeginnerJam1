class_name Level
extends Node2D

#region export variables

@export var _tilemap : TileMapLayer

#endregion

#region virtual methods

func _ready() -> void:
	assert(_tilemap is TileMapLayer, "Tilemap reference missing from the Level")
	Map._tilemap = _tilemap

#endregion
