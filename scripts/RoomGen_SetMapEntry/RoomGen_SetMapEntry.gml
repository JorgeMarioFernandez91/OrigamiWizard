/// @function							RoomGen_SetMapEntry(room_num, map_key, map_value);
/// @param {int}			room_num	The room num to set the map of
/// @param {string/real]	map_key		The map key to use
/// @param {string/real}	map_value	The value to set the map key to

/// @description						With this script you can set a map entry for a given room.

var _map = RoomGen_GetRoomMap(argument0);
if _map != -1
{
_map[? argument1] = argument2;
return true;
}
else
{
show_debug_message("RoomGen_SetMapEntry: Map for room " + string(argument0) + " does not exist");
show_debug_message("RoomGen_SetMapEntry: Returning false");
return false;
}