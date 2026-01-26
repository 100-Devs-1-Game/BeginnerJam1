class_name TestLevel
extends Level

## Test Level script extending from base Level script
## can be used to test certain features in the Test Scene
## while the base Level class should contain feature that are common to all Levels

#region constants

const TEST_MAP_CONVERSION := true

#endregion

func _process(_delta: float) -> void:
	if TEST_MAP_CONVERSION:
		_test_map_conversion()
	

## Prints the mouse global position and its corresponding grid position
func _test_map_conversion() -> void:
	var mouse_pos := get_global_mouse_position()
	var grid_pos := Map.global_to_map(mouse_pos)
	var global_pos := Map.map_to_global(grid_pos)
	
	prints("Mouse position", mouse_pos, "-> Grid position", grid_pos, "-> Global position", global_pos)


func _test_tile_data() -> void:
	var mouse_pos := get_global_mouse_position()
	var grid_pos := Map.global_to_map(mouse_pos)
	
	print("Mouse position ", mouse_pos, " -> Grid position ", grid_pos)
