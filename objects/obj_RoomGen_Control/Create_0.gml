/// @description Initialise Room

// Get the current room number...
// Note that on the first run, the room X and Y values will ALWAYS be set
// to the position of the room flagged with "start" in the room DS map, but
// as we move through the rooms, we'll change these values (see the STEP EVENT 
// of the player object - the part where we check to see if the player has
// left through a door).

// Get the number of of the current "room"
var num = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);

// Get the DS map associated with the room
var map = RoomGen_GetRoomMap(num);

// Get the first entry in the map
var pos = ds_map_find_first(map);

// If we are in the first room then activate flag
show_instruction = false;

// Parse the map to find out where the entances to the room are and create doors/walls as required
// You can also use this parsing of the map to create additional room elements that you 
// have added into the map when it was generated. See the script "RoomGen_End_DEMO".
show_debug_message("-----------------------------");

// Loop through the map to extract the required data
for (var i = 0; i < ds_map_size(map); i++;)
{
show_debug_message(pos + string(map[? pos])); // Show data output
// Extract the map data for the current position within the map
switch(pos)
    {
    case "top": // Check to see if there is a door at the top of the room
        if map[? pos] == true
            {
            var inst = instance_create_layer(room_width / 2, 0, "Instances", obj_Door);
			inst.sprite_index = spr_Closed_Door_H;
            }
        else
            {
            // No door so cover the space where it would go
			RoomGen_Cover_Doors("Sprite_Walls", bck_RoomGen_Walls_Covers_01, 0, room_width / 2, 32, map[? "background"]);
            }
        break;
    case "bottom": // Check to see if there is a door at the bottom of the room
        if map[? pos] == true
            {
            var inst = instance_create_layer(room_width / 2, room_height, "Instances", obj_Door);
			inst.sprite_index = spr_Closed_Door_H;
            inst.image_yscale = -1;
            }
        else
            {
			// No door so cover the space where it would go
			RoomGen_Cover_Doors("Sprite_Walls", bck_RoomGen_Walls_Covers_02, 0, room_width / 2, room_height - 32, map[? "background"]);
            }
        break;
    case "left": // Check to see if there is a door on the left of the room
        if map[? pos] == true
            {
            var inst = instance_create_layer(0, room_height / 2, "Instances", obj_Door);
			inst.sprite_index = spr_Closed_Door_V;
            }
        else
            {
            // No door so cover the space where it would go
            RoomGen_Cover_Doors("Sprite_Walls", bck_RoomGen_Walls_Covers_03, 0, 32, room_height / 2, map[? "background"]);
            }
        break;
    case "right": // Check to see if there is a door on the right of the room
        if map[? pos] == true
            {
            var inst = instance_create_layer(room_width, room_height / 2, "Instances", obj_Door);
            inst.sprite_index = spr_Closed_Door_V;
			inst.image_xscale = -1;
            }
        else
            {
            // No door so cover the space where it would go
			RoomGen_Cover_Doors("Sprite_Walls", bck_RoomGen_Walls_Covers_04, 0, room_width - 32, room_height / 2, map[? "background"]);
            }
        break;
    case "enter":
        // Get the "enter" map entry to find out where the player 
        // has come from and position him as required
        switch(map[? "enter"])
            {
			case 0: // Top
                var inst = instance_create_layer(room_width / 2, 64, "Instances", obj_Player);
                inst.image_angle = 0;	//what angle to draw the player sprite
                break;
            case 1: // Bottom
                var inst = instance_create_layer(room_width / 2, room_height - 64, "Instances", obj_Player);
                inst.image_angle = 0;
                break;
            case 2: // Left
                var inst = instance_create_layer(64, room_height / 2, "Instances", obj_Player);
                inst.image_angle = 0;
                break;
            case 3: // Right
                var inst = instance_create_layer(room_width - 64, room_height / 2, "Instances", obj_Player);
                inst.image_angle = 0;
                break;
            }
        break;
    case "start":
	        // Create the player instance in the middle of the first room ONLY if it hasn't been entered before
	        if map[? "start"] {
	            if map[? "visited"] == false {
	                var inst = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Player);
	                map[? "visited"] = true; // Flag the room as having been visited
				
					show_instruction = true;	// in the first room we want to show instructions
	            }
	        }
			else{
				show_instruction = false;	// in any other room we do not want to show instructions
			}
        break;
    case "end":
        // Check to see if the room is the exit room and create Exit object if it is
        if map[? "end"]
            {
				//do nothing
            }
        break;   

    case "background": // Set the background colour so rooms have more variety
		var _layer = layer_get_id("Background_Walls");
		var _back = layer_background_get_id(_layer);
		layer_background_blend(_back, map[? "background"]);
        break;
    case "enemy": // Create enemies
        // We have two peices of information stored in the "enemy" key of the map:
        // the type and the number. So we split the string in two to get each 
        // individual value, then parse each of them to create the correct enemy.
        var _type = string_letters(map[? "enemy"]);
        var _num = string_digits(map[? "enemy"]);
        repeat(_num)
            {
            var _xx = 128 + random(room_width - 256);
            var _yy = 128 + random(room_height - 256);
            with (instance_create_layer(_xx, _yy, "Instances", obj_Enemy))
                {
                switch(_type)
                    {
					case "goblin":
                        sprite_index = spr_Goblin;
                        spd = 2;
                        hp = 3;		// change the health of the goblin enemy
                        break;
					case "boss":
						sprite_index = spr_boss;
						spd = 2;
						hp = 20;
                    }
                }
            }
        break;
    }
pos = ds_map_find_next(map, pos);
}

// Check to see if the room has been visited before.
// If it is, open all the doors (this check CANNOT go in the map parsing (above)
// as it may be that not all the doors have been created when it is parsed...).
// This is not essential and will depend on thegame you are making. In this DEMO
// we are saving the room state to the room map in the "visited" key, so that 
// when we go back to a room it is NOT reset, but in your own games you can do 
// whatever you want!
if map[? "visited"] == true
{
show_debug_message("Doors Opened");
with (obj_Door)
    {
    //if sprite_index == spr_RoomGen_DoorClosed_H
	if sprite_index == spr_Closed_Door_H
        {
        sprite_index = spr_Open_Door_H;
        if image_yscale == 1
            {
            with (instance_position(x - 32, y + 32, obj_Wall)) instance_destroy();
            with (instance_position(x + 32, y + 32, obj_Wall)) instance_destroy();
            }
        else
            {
            with (instance_position(x - 32, y - 32, obj_Wall)) instance_destroy();
            with (instance_position(x + 32, y - 32, obj_Wall)) instance_destroy();
            }
        }
    //if sprite_index == spr_RoomGen_DoorClosed_V
	if sprite_index == spr_Closed_Door_V
        {
        sprite_index = spr_Open_Door_V;
        if image_xscale == 1
            {
            with (instance_position(x + 32, y - 32, obj_Wall)) instance_destroy();
            with (instance_position(x + 32, y + 32, obj_Wall)) instance_destroy();
            }
        else
            {
            with (instance_position(x - 32, y - 32, obj_Wall)) instance_destroy();
            with (instance_position(x - 32, y + 32, obj_Wall)) instance_destroy();
            }
        }
    }
}

// Set a new map entry to show the room has been visited
map[? "visited"] = true;




