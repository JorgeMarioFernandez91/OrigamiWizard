/// @function					RoomGen_GetRoom_x(room_num)
/// @param {int}	room_num	The number of the room to get the grid X position from 

/// @description				This script can be used to rtetrieve the X position of a room
///								within the main room gen DS grid. You give the room number to
///								get the x position of the script will return an integer value
///								from 0 to (grid width - 1), or a value of -1 if there is an 
///								error.


var _map = RoomGen_GetRoomMap(argument0);
if _map != -1
{
var _gridw = ds_grid_width(global.RoomGen_grid);
var _gridh = ds_grid_height(global.RoomGen_grid);
return ds_grid_value_x(global.RoomGen_grid, 0, 0, _gridw, _gridh, _map);
}
else
{
show_debug_message("RoomGen_GetRoom_x: Cannot get X position for room " + string(argument0));
show_debug_message("RoomGen_GetRoom_x: Returning -1");
return -1;
}
