## Used in Globals as 'Map'
class_name MapManager
extends Node

#region constants

const TILE_SIZE := Vector2i(32, 32)

#endregion

#region private variables

## Current level's tilemap, shouldn't be accessed directly
var _tilemap: TileMapLayer

#endregion

#region main methods

## Convert an entity's [param global_position] to their Map Cordinates
func global_to_map(global_position: Vector2) -> Vector2i:
	assert(_tilemap is TileMapLayer)
	var local_pos := _tilemap.to_local(global_position) # Handles transform/scaling/negative coordinates
	return _tilemap.local_to_map(local_pos)


## Convert an entity's [param grid_position] to their global position
func map_to_global(grid_position: Vector2i) -> Vector2i:
	assert(_tilemap is TileMapLayer)
	var local_pos := _tilemap.map_to_local(grid_position)
	return _tilemap.to_global(local_pos)


## Returns the value of the custom data [param data_name]
## from the map coordinates [param grid_position].
## Returns a [Variant] which type should be checked
func get_custom_data(grid_position: Vector2i, data_name: String) -> Variant:
	assert(_tilemap is TileMapLayer)
	var data := _tilemap.get_cell_tile_data(grid_position)
	assert(data, "Looking up a tile without data")
	return data.get_custom_data(data_name) # Returns a variant

#endregion


#region specific methods


#endregion
