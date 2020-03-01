/// @function		RoomGen_CreateRoom_Constrained()

/// @description	This is the CONSTRAINED version of the general room generator script.
///					THIS SCRIPT SHOULD ONLY BE USED IF YOU USED THE CONSTRAINED INIT SCRIPT!
///					
///					This script checks around the current "room" cell in the DS grid to 
///					see if there can be a door added (at random) to a specific side. It 
///					will check the room_x/room_y position within the grid to see if the 
///					chosen room is outside of the current grid bounds and if it is, it 
///					will try to backtrack to another room or add a new door to the current 
///					one.
///					
///					Once we have a direction a door is added into a DS map that is stored
///					within the DS grid (this will be removed later... see the "RoomGen_End"
///					script). This DS map will hold keys for "top", "bottom", "left" and 
///					"right" to mark which door has been added. After adding the door to 
///					the map, the grid position is updated to the new "room" cell and the 
///					DS map for that new room also has a corresponding door added. For
///					example, if the current room chooses "up", then the DS map will have
///					a key "up" added and set to (true). The room position within the 
///					grid will then move up one and the map associated with that cell
///					will have a DS map key of "bottom" added and set to (true) as well.
///					
///					This script is "internal" and should normally NOT be called
///					on its own except in a debug sitiuation, although you could use it 
///					to graphically show the player a level being built, for example 
///					(as is shown in the DEMO room). Normally it will be called from the
///					"RoomGen_CreateAllRooms" script though.
///					
///					Note that this is classed as "Bonus content" as I don't really like 
///					the mazes it produces, but can see how others may find it useful. :)


// Init vars
var t_map = -4;                                    // Temporary ds_map holder variable

var grid_w = ds_grid_width(global.RoomGen_grid);   // Width of the global room grid
var grid_h = ds_grid_height(global.RoomGen_grid);  // Height of the global room grid

var list = ds_list_create();                       // We will use this list to choose a door placement
var map = global.RoomGen_grid[# room_x, room_y];

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug
{
show_debug_message("--------------------------------");
show_debug_message("RoomGen_CreateRoom_Constrained: Current Room Number = " + string(room_num));
show_debug_message("RoomGen_CreateRoom_Constrained: Current Room ID = " + string(map[? "room"]));
}
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////

// Lets first check and see what positions are open for a door.
// First we check to see if a door ralready exists, and if it doesn't 
// then we check that direction to make sure it is still constrained
// within the grid bounds. If the position is within the grid and 
// doesn't have a door, it is added to the list.
if !ds_map_exists(map, "top")
    {
    if room_y - 1 > -1 ds_list_add(list, "top");
    }
if !ds_map_exists(map, "bottom")
    {
    if room_y + 1 < grid_h ds_list_add(list, "bottom");
    }
if !ds_map_exists(map, "left")
    {
    if room_x - 1 > -1 ds_list_add(list, "left");
    }
if !ds_map_exists(map, "right")
    {
    if room_x + 1 < grid_w ds_list_add(list, "right");
    }

// We need to check to see if the door list is empty or not. If it is
// it means that the room either has all 4 doors OR the combination of 
// doors and grid edges makes it impossible to add more doors.
if ds_list_size(list) == 0
{
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Can't create new room!");
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
// So we can't create a door in this room, which means we need to go to
// another room in the grid. The room being checked must have at least 
// one door to it, so we go through the available doors and add them to 
// the list.
if ds_map_exists(map, "top") ds_list_add(list, "top");
if ds_map_exists(map, "bottom") ds_list_add(list, "bottom");
if ds_map_exists(map, "left") ds_list_add(list, "left");
if ds_map_exists(map, "right") ds_list_add(list, "right");
// Now we randomise the list and get the first one from it. This will be 
// the direction that we move the room grid position to so that we can
// check again and continue.
ds_list_shuffle(list);
switch(list[| 0])
    {
    case "top": room_y--; break;
    case "bottom": room_y++; break;
    case "left": room_x--; break;
    case "right": room_x++; break;
    }
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug
    {
    var m = global.RoomGen_grid[# room_x, room_y];
    show_debug_message("RoomGen_CreateRoom_Constrained: Moving to room " + string(m[? "room"]));
    }
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
ds_list_destroy(list);
}
else
{
// We have a list of possible directions to add a door to, so randomise it
// and then do a check to see how many doors are on the list. If there are
// Less than 4 possible directions to choose from, let's take a chance on 
// picking an existing door instead of adding a new one. This helps cut down 
// on the number of rooms that will have four doors when "clumped".
ds_list_shuffle(list);
if ds_list_size(list) < 4
    {        
    var side = choose("top", "bottom", "left", "right");
    if ds_map_exists(map, side)
        {
        switch(side)
            {
            case "top": room_y--; break;
            case "bottom": room_y++; break;
            case "left": room_x--; break;
            case "right": room_x++; break;
            }
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Skip Room!");
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        ds_list_destroy(list);
        // We are moving to a new room so exit the script...
        exit;
        }
    }
// Check the chosen random direction for room details and 
// adapt the DS grid as required before setting door direction
switch(list[| 0])
    {
    case "top":
        // Check current room map to see if top is flagged as used
        var map = global.RoomGen_grid[# room_x, room_y];
        if !ds_map_exists(map, "top")
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Room added TOP");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            // Top isn't used so add it and change the current room to the new room
            map[? "top"] = true;
            --room_y;
            // Check to see if the new room has a ds_map associated already
            t_map = global.RoomGen_grid[# room_x, room_y];
            if t_map == -4
                {
                // New room has no ds_map, so create it...
                global.RoomGen_grid[# room_x, room_y] = ds_map_create();
                t_map = global.RoomGen_grid[# room_x, room_y];
                }
            // New room needs to have the bottom door flagged as used
            t_map[? "bottom"] = true;
            }
        else
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Double Back!");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            room_y--;
            }
        break;
    case "bottom":
        // Check current room map to see if top is flagged as used
        var map = global.RoomGen_grid[# room_x, room_y];
        if !ds_map_exists(map, "bottom")
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Room added BOTTOM");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            // Bottom isn't used so add it and change the current room to the new room
            map[? "bottom"] = true;
            ++room_y;
            // Check to see if the new room has a ds_map associated already
            t_map = global.RoomGen_grid[# room_x, room_y];
            if t_map == -4
                {
                // New room has no ds_map, so create it...
                global.RoomGen_grid[# room_x, room_y] = ds_map_create();
                t_map = global.RoomGen_grid[# room_x, room_y];
                }
            // New room needs to have the top door flagged as used
            t_map[? "top"] = true;
            }
        else
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Double Back!");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            room_y++;
            }
        break;
    case "left":
        // Check current room map to see if top is flagged as used
        var map = global.RoomGen_grid[# room_x, room_y];
        if !ds_map_exists(map, "left")
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Room added LEFT");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            // Left isn't used so add it and change the current room to the new room
            map[?"left"] = true;
            --room_x;
            // Check to see if the new room has a ds_map associated already
            t_map = global.RoomGen_grid[# room_x, room_y];
            if t_map == -4
                {
                // New room has no ds_map, so create it...
                global.RoomGen_grid[# room_x, room_y] = ds_map_create();
                t_map = global.RoomGen_grid[# room_x, room_y];
                }
            // New room needs to have the right door flagged as used
            t_map[? "right"] = true;
            }
        else
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Double Back!");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            room_x--;
            }
        break;
    case "right":
        // Check current room map to see if top is flagged as used
        var map = global.RoomGen_grid[# room_x, room_y];
        if !ds_map_exists(map, "right")
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Room added RIGHT");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            // Right isn't used so add it and change the current room to the new room
            map[? "right"] = true;
            ++room_x;
            // Check to see if the new room has a ds_map associated already
            t_map = global.RoomGen_grid[# room_x, room_y];
            if t_map == -4
                {
                // New room has no ds_map, so create it...
                global.RoomGen_grid[# room_x, room_y] = ds_map_create();
                t_map = global.RoomGen_grid[# room_x, room_y];
                }
            // New room needs to have the left door flagged as used
            t_map[? "left"] = true;
            }
        else
            {
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom_Constrained: Double Back!");
            // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
            room_x++;
            }
        break;
    }
    
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
// Show the state of the room map for debugging
if global.RoomGen_Debug 
    {
    if map != -4
        {
        var _val = ds_map_find_first(map);
        var _str = "RoomGen_CreateRoom_Constrained: Room map {";
        for (var i = 0; i < ds_map_size(map); i++;)
            {
            if _val == "room"
                {
                _str += _val + ":" + string(map[? _val]);
                }
            else _str += _val + ", ";
            _val = ds_map_find_next(map, _val);
            }
        _str += "}";
        show_debug_message(_str);
        }
    }
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////

// Check to make sure that the previous map was created
if t_map != -4
    {
    // Map exists, now to check if it's been registered as a room already
    if !ds_map_exists(t_map, "room")
        {
        // Map hasn't been registered, so do that now...
        t_map[? "room"] = ++room_num;
        ds_list_add(global.RoomGen_list, t_map);
        }
    }
ds_list_destroy(list);
}

