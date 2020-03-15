/// @description Init Room Map

/* ////////////////////////////////////////////////////////////

This is a base object that will generate two data structures:

global.RoomGen_grid - A DS grid that contains all the rooms generated as a grid
global.RoomGen_list - A DS list that contains all the room MAPS generated, in order of creation

You initialise the DS grid using the "Init" script, giving the 
number of rooms you want to generate and whether you want the 
rooms to be able to "double back" over previous rooms (this will
give a more condenced map, while leaving it off will make them
more linear).

The global DS grid is then created and populated in the "CreateAllRooms" 
script. Each individual room is stored as a DS Map, where each map entry
defines the contants and doors etc... for the room.

Finally, the DS list is created in the "End" script. This is also 
where you would add extra scripts to populate the rooms with additional
data, like enemies, or keys, or pickups, etc...

Don't forget that you will also need to call the script "RoomGen_CleanUp"
when you no longer require the room data structures. This is NOT done when 
the instance is destroyed, nor at the end of the room. You would clean 
up the system ONLY WHEN THE PLAYER LEAVES THE GAME to go back to the main 
menu or when they die, etc.... Cleaning up the room system will crash
the game if done while instances still need access to the data.

//////////////////////////////////////////////////////////// */

//RoomGen_Init(50, false);
//RoomGen_CreateAllRooms(false);
//RoomGen_End();

////////////

// This is a DEMO object to show how to use the scripts supplied.
// This object simply generates a new room map over a number of 
// steps instead of all at once and can be removed from the project
// along with all the other Objects/Sprites/Rooms marked DEMO.

// Get the number of rooms, whether to double back and the debug resolution
//var num = irandom_range(10, 30);

var num = 6;	//changes the number of rooms

var dob = choose("true", "false");
res = 64;

draw = false;

// Initialise the romm generator
if string_lower(dob) == "true"
{
RoomGen_Init_LVL_2(num, true, true);
}
else
{
RoomGen_Init_LVL_2(num, false, true);
}

// Set an alarm to iterate through the scripts and generate room 
// spaces one at a time (normally all generation would go here)
alarm[0] = room_speed;


