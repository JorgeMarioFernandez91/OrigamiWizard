/// @function							RoomGen_ClearMapEntry(room_num, map_key);
/// @param {int}			room_num	The number of the room to clear the map entry for
/// @param {real/string}	map_key		The map entry key to clear

/// @description						You can use this script to clear a DS map entry from a given room

var _map = RoomGen_GetRoomMap(argument0);

if _map != -1
{
if ds_map_exists(_map, argument1)
	{
	ds_map_delete(_map, argument1);
	return true;
	}
else
	{
	show_debug_message("RoomGen_ClearMapEntry: Map key " + string(argument1) + "for room " + string(argument0) + " does not exist");
	show_debug_message("RoomGen_ClearMapEntry: Returning false");
	return false;
	}
}
else
{
show_debug_message("RoomGen_ClearMapEntry: Map for room " + string(argument0) + " does not exist");
show_debug_message("RoomGen_ClearMapEntry: Returning false");
return false;
}
