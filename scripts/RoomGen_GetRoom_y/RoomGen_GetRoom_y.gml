/// @function					RoomGen_GetRoom_y(room_num)
/// @param {int}	room_num	The number of the room to get the grid Y position from 

/// @description				This script can be used to rtetrieve the Y position of a room
///								within the main room gen DS grid. You give the room number to
///								get the x position of the script will return an integer value
///								from 0 to (grid height - 1), or a value of -1 if there is an 
///								error.

var _map = RoomGen_GetRoomMap(argument0);
if _map != -1
{
var _gridw = ds_grid_width(global.RoomGen_grid);
var _gridh = ds_grid_height(global.RoomGen_grid);
return ds_grid_value_y(global.RoomGen_grid, 0, 0, _gridw, _gridh, _map);
}
else
{
show_debug_message("RoomGen_GetRoom_y: Cannot get Y position for room " + string(argument0));
show_debug_message("RoomGen_GetRoom_y: Returning -1");
return -1;
}

