/// @function		RoomGen_CreateRoom();

/// @description	This script checks around the current "room" cell in the DS grid to 
///					see if there can be a door added (at random) to a specific side. It 
///					will check the room_x/room_y position within the grid to see if the 
///					chosen room is outside of the current grid bounds and if it is, extend 
///					the grid to accomodate (to keep memory use to a minimum).
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

var t_map = -4;                                 // Temporary ds_map holder variable
randomize();
var ranroom = irandom(3);                       // Random direction to go in (0 = top, 1 = bottom, 2 = left, 3 = right)

var grid_w = ds_grid_width(global.RoomGen_grid);   // Width of the global room grid
var grid_h = ds_grid_height(global.RoomGen_grid);  // Height of the global room grid

var _chk = false;

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
if global.RoomGen_Debug
{
show_debug_message("--------------------------------");
show_debug_message("RoomGen_CreateRoom: Current Room = " + string(room_num));
}
// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////

// Check the chosen random direction for room details and 
// adapt the DS grid as required before setting door direction
switch(ranroom)
{
case 0: // Expand upwards if required
    if room_y - 1 < 0
        {
        var t_grid = ds_grid_create(grid_w, grid_h);
        ds_grid_copy(t_grid, global.RoomGen_grid);
        ds_grid_resize(global.RoomGen_grid, grid_w, grid_h + 1);
        ds_grid_clear(global.RoomGen_grid, -4);
        ds_grid_set_grid_region(global.RoomGen_grid, t_grid, 0, 0, grid_w, grid_h, 0, 1);
        ds_grid_destroy(t_grid);
        room_y++;
        }
    // Check current room map to see if top is flagged as used
    var map = global.RoomGen_grid[# room_x, room_y];
    if !ds_map_exists(map, "top")
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Room added TOP");
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
    else if room_rpt // Check to see if the generator can "double back" on itself
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Double Back!");
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        room_y--;
        }
    else _chk = true;
    break;
case 1: // Expand down
    if room_y + 1 >= grid_h
        {
        var t_grid = ds_grid_create(grid_w, grid_h);
        ds_grid_copy(t_grid,global.RoomGen_grid);
        ds_grid_resize(global.RoomGen_grid, grid_w, grid_h + 1);
        ds_grid_clear(global.RoomGen_grid, -4);
        ds_grid_set_grid_region(global.RoomGen_grid, t_grid, 0, 0, grid_w, grid_h, 0, 0);
        ds_grid_destroy(t_grid);
        }
    // Check current room map to see if top is flagged as used
    var map = global.RoomGen_grid[# room_x, room_y];
    if !ds_map_exists(map, "bottom")
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Room added BOTTOM");
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
    else if room_rpt // Check to see if the generator can "double back" on itself
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Double Back!");
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        room_y++;
        }
    else _chk = true;
    break;
case 2: // Expand left
    if room_x - 1 < 0
        {
        var t_grid = ds_grid_create(grid_w, grid_h);
        ds_grid_copy(t_grid,global.RoomGen_grid);
        ds_grid_resize(global.RoomGen_grid, grid_w + 1, grid_h);
        ds_grid_clear(global.RoomGen_grid, -4);
        ds_grid_set_grid_region(global.RoomGen_grid, t_grid, 0, 0, grid_w, grid_h, 1, 0);
        ds_grid_destroy(t_grid);
        room_x++;
        }
    // Check current room map to see if top is flagged as used
    var map = global.RoomGen_grid[# room_x, room_y];
    if !ds_map_exists(map, "left")
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Room added LEFT");
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
    else if room_rpt // Check to see if the generator can "double back" on itself
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Double Back!");
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        room_x--;
        }
    else _chk = true;
    break;
case 3: // Expand right
    if room_x + 1 >= grid_w
        {
        var t_grid = ds_grid_create(grid_w, grid_h);
        ds_grid_copy(t_grid,global.RoomGen_grid);
        ds_grid_resize(global.RoomGen_grid, grid_w + 1, grid_h);
        ds_grid_clear(global.RoomGen_grid, -4);
        ds_grid_set_grid_region(global.RoomGen_grid, t_grid, 0, 0, grid_w, grid_h, 0, 0);
        ds_grid_destroy(t_grid);
        }
    // Check current room map to see if top is flagged as used
    var map = global.RoomGen_grid[# room_x, room_y];
    if !ds_map_exists(map, "right")
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Room added RIGHT");
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
    else if room_rpt // Check to see if the generator can "double back" on itself
        {
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Double Back!");
        // DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
        room_x++;
        }
    else _chk = true;
    break;
}

// DEBUG! ///////////////////////////////////////////////////////////////////////////////////////////
// Show the state of the room map for debugging
if global.RoomGen_Debug 
{
if map != -4
    {
    var _val = ds_map_find_first(map);
    var _str = "RoomGen_CreateRoom: Room map {";
    for (var i = 0; i < ds_map_size(map); i++;)
        {
        if _val == "room"
            {
            _str += _val + ":" + string(map[? _val]) + ", ";
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
else
    {
    // This is an additional check in case the non-double back option
    // results in the current room having ALL doors taken. It will simply
    // choose a random direction to move to and continue if this happens.
    if _chk
        {
        if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: No room added.");
        if ds_exists(map, ds_type_map)
            {
            if ds_map_size(map) > 4
                {
                var _val = ds_map_find_first(map);
                for (var i = 0; i < ds_map_size(map); i++;)
                    {
                    if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: " + string(_val + string(ds_map_find_value(map, _val))));
                    _val = ds_map_find_next(map, _val);
                    }
                if global.RoomGen_Debug show_debug_message("RoomGen_CreateRoom: Room has all doors! Moving on...");
                if choose(true, false)
                    {
                    room_y += choose(1, -1);
                    }
                else
                    {
                    room_x += choose(-1, 1);
                    }
                }
            }
        }
    }
