/// @function					RoomGen_GetRoomMap(room_num);
/// @param {int}	room_num	The number of the room to get the map data from

/// @description				This script can be used to retrieve the DS map data 
///								for any room within the room DS list. You supply the
///								The room number (from 0 to total_rooms - 1) and the 
///								script will return the DS map for the room or it will
///								return -1 if there is an error.

var _map = global.RoomGen_list[| argument0];
if is_undefined(_map)
{
show_debug_message("RoomGen_GetRoomMap: Map undefined for room " + string(argument0));
show_debug_message("RoomGen_GetRoomMap: Returning -1");
return -1;
}
else if !ds_exists(_map, ds_type_map)
{
show_debug_message("RoomGen_GetRoomMap: Room " + string(argument0) + " data is not a DS Map");
show_debug_message("RoomGen_GetRoomMap: Returning -1");
return -1;
}

return _map;

