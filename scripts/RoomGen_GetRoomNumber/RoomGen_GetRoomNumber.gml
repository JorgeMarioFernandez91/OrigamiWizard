/// @function					RoomGen_GetRoomNumber(x_cell, y_cell);
/// @param {int}	x_cell		The x position of the gird cell to use
/// @param {int]	y_cell		The y position of the grid cell to use

/// @description				This script can be used to get the room number for any given cell 
///								of the global room DS grid. If the values given are outside of the 
///								grid bounds the script will return -1.

if argument0 < 0 || argument0 >= ds_grid_width(global.RoomGen_grid)
{
show_debug_message("RoomGen_GetRoomNumber: X Value " + string(argument0) + " is outside grid bounds (0 - " + string(ds_grid_width(global.RoomGen_grid) - 1) + ").");
show_debug_message("RoomGen_GetRoomNumber: Returning -4");
return -4;
}
else if argument1 < 0 || argument1 >= ds_grid_height(global.RoomGen_grid)
{
show_debug_message("RoomGen_GetRoomNumber: Y Value " + string(argument1) + " is outside grid bounds (0 - " + string(ds_grid_height(global.RoomGen_grid) - 1) + ").");
show_debug_message("RoomGen_GetRoomNumber: Returning -4");
return -4;
}
else
{
var _m = global.RoomGen_grid[# argument0, argument1];
if ds_exists(_m, ds_type_map)
	{
	return _m[? "room"];
	}
else return -4;
}
