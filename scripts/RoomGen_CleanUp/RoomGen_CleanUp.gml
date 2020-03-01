/// @function					RoomGen_CleanUp([optional - restart]);
/// @param {bool}	[restart]	OPTIONAL! Recreate or not the room grid

/// @description				This script cleans up the various data structures used by the
///								generation scripts. This script should ONLY BE CALLED WHEN THE
///								PLAYER DIES (or whatever condition it is that returns the player
///								to the start screen) as game rooms will no longer work after
///								this has been called. So, for example, you would call the INIT 
///								script at the end of a Menu Room when it is time to enter the 
///								main game, then you'd call this CLEANUP script when the player
///								dies or quits the main game.
///								
///								This script takes an OPTIONAL single argument (true / false) to 
///								flag whether the room generator should be re-created or not (this 
///								is only for use when there is an error in the generation - see
///								the script RoomGen_End).

for (var i = 0; i < ds_list_size(global.RoomGen_list); i++;)
    {
    // Get the DS map ID for the room
    var map = global.RoomGen_list[| i];
    // Destroy the map
    if ds_exists(map, ds_type_map)
        {
        ds_map_destroy(map);
        }
    }
// Destroy the global DS List
ds_list_destroy(global.RoomGen_list);
// Destroy the global DS Grid
ds_grid_destroy(global.RoomGen_grid);

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug show_debug_message("RoomGen_CleanUp: Room Gen Cleaned!");
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////

// Recreate the room gen object if there has been an error
if argument_count > 0
{
if global.RoomGen_Debug show_debug_message("RoomGen_CleanUp: Restarting...");
if argument[0] == true instance_create_layer(x, y, "Instances", object_index);
}
