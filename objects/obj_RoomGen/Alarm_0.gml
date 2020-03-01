// Iterate through the global DS grid for rooms one cell at a time
// and generate a room DS map for each.

RoomGen_CreateRoom();

// Check to see if we have generated all the required rooms and
// if we have, call an alarm to call the End script.
if room_num < room_max - 1
    {
    alarm[0] = 5;
    }
else
    {
    alarm[1] = room_speed;
    }


