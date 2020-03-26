/// @function						RoomGen_Init(num_of_rooms, double_back, [debug]);
/// @param {int}	num_of_rooms	The number of rooms to generate
/// @param {bool}	double_back		Whether to permit room to "double-back" over previously flagged rooms
/// @param {bool}	[debug]			OPTIONAL! Whether to debug the generation or not

/// @description					This script initialises all the required variables as well as
///									creates the two GLOBAL scope Data Structures -  A DS grid and a 
///									DS list. The grid will first be 1x1 in size and then expand as 
///									required to create the room spaces (thus keeping memory to a 
///									minimum). Each room space will then be stored in the DS list at 
///									the end of the generation. See the "RoomGen_End" script comments
///									for more information.
///									
///									You also get two global variables created to hold the X / Y position
///									of the room currently being played within the main DS grid.These can 
///									then be used with the "helper" functions to get the current room 
///									number and map.
///									
///									Note that you have an optional argument to enable debug logging.
///									Setting this to true will push important debug messages to console.

room_num = 0;             // The number of rooms currently
room_max = argument[0];   // The maximum number of rooms to create
room_rpt = argument[1];   // Whether to "double back" on previously visited rooms (true/false)

//room_max = 5;   // The maximum number of rooms to create
//room_rpt = true;  // Whether to "double back" on previously visited rooms (true/false)

// Note the double-back option is better used when creating smaller mazes
// with 20 or less rooms. For larger mazes it's usually best left off...

room_x = 0;             // The current X position within the DS grid
room_y = 0;             // The current Y position within the DS grid

// Create the global data structures
global.RoomGen_list = ds_list_create();
global.RoomGen_grid = ds_grid_create(1, 1);

global.Player_health = 20;
global.Max_health = 20;
global.Powerup1 = false;	//split attacks
global.Powerup2 = false;	//more damage

global.Restart = false;


global.Enemy_kills = 0;
global.Origami_cooldown = 0;
global.Origami_available = false;

global.time = date_current_datetime();


// Create global helper vars
global.RoomGen_x = 0;
global.RoomGen_y = 0;
global.RoomGen_Debug = false;
if argument_count > 2
{
global.RoomGen_Debug = argument[2];
//global.RoomGen_Debug = false;
}

// Clear the grid to -4
ds_grid_clear(global.RoomGen_grid, -4);

// Create a new DS Map and assign its ID value to the current room grid cell
// Data for each room within the grid is stored within a DS map, so things
// like doors and start / end position are easily stored.
global.RoomGen_grid[# room_x, room_y] = ds_map_create();

// Add the initial room number into the room map
ds_map_add(global.RoomGen_grid[# room_x, room_y], "room", room_num);
// Add the initial room map into the room list
ds_list_add(global.RoomGen_list, global.RoomGen_grid[# room_x, room_y]);
//randomize();

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug
{
show_debug_message("--------------------------------");
show_debug_message("Room Generator Initialised");
show_debug_message("--------------------------------");
}
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////



