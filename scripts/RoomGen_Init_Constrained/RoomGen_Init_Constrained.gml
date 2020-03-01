/// @function						RoomGen_Init_Constrained(num_of_rooms, grid_w, grid_h, [debug]);
/// @param {int}	num_of_rooms	The total number of rooms to create
/// @param {int}	grid_w			The width of the room grid
/// @param {int}	grid_h			The height of the room grid
/// @param {bool}	[debug]			Enable/disable debugging

/// @description					This script is for initialising a CONSTRAINED room grid. A constrained
///									grid is one that has a fixed width and height. When creating constrained 
///									grids YOU MUST MAKE SURE THAT THERE ARE MORE GRID CELLS THAN ROOMS TO BE 
///									CREATED! So if you have 50 rooms, the grid must be more than 7x7 (49 cells)
///									Ideally you really want at least 25% more cells than rooms, but different
///									ratios will create different effects, so experiment...
///									
///									Note that consttrained room generation usually leads to more densly packed
///									rooms with a greater number of connections, although the script
///									"CreateRoom_Constrained" will randomly try to pick a previously visited
///									room rather than add a new door to the current room to try and prevent 
///									too many rooms with 4 doors.
///									
///									This script initialises all the required variables as well as
///									creates the two GLOBAL scope Data Structures -  A DS grid and a 
///									DS list and two global scope variables to hold the current 
///									"room" position within the DS grid.
///									
///									Note that you have an optional argument to enable debug logging.
///									Setting this to true will push important debug messages to console.

room_num = 0;             // The number of rooms currently
room_max = argument[0];   // The maximum number of rooms to create
room_rpt = true;          // Whether to "double back" on previously visited rooms (true/false)

// Note the double-back option is better used when creating smaller mazes
// with 20 or less rooms. For larger mazes it's usually best left off...

// Create the global data structures
global.RoomGen_list = ds_list_create();
global.RoomGen_grid = ds_grid_create(argument[1], argument[2]);

room_x = floor(argument[1] / 2);             // The current X position within the DS grid
room_y = floor(argument[2] / 2);             // The current Y position within the DS grid

// Create global helper vars
global.RoomGen_x = 0;
global.RoomGen_y = 0;
global.RoomGen_Debug = false;
if argument_count > 3
{
global.RoomGen_Debug = argument[3];
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
randomize();

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug
{
show_debug_message("--------------------------------");
show_debug_message("Room Generator Initialised (Constrained)");
show_debug_message("--------------------------------");
}
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////



