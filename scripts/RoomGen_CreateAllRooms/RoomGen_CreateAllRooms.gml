/// @function						RoomGen_CreateAllRooms(constrained)
/// @param {bool}	constrained		Set whether to constrain the rooms to within the grid bounds or not

/// @description					This is a wrapper script to create all the rooms in the room grid at once.
///									In your games THIS is the script you would normally call, as the single
///									room generation script is only designed for debugging, not for actual use,
///									although you can use it and generate a map visually for the player to see
///									if you wish, as shown in the DEMO object that comes with this asset.

if argument0 == true
{
while (room_num < room_max - 1)
    {
    RoomGen_CreateRoom_Constrained();
    }
}
else
{
while (room_num < room_max - 1)
    {
    RoomGen_CreateRoom();
    }
}
