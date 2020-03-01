
if (sprite_index == spr_Player){		// movement for apprentice 
	
	//move player with WASD
	if keyboard_check(ord("A")){
		x = x - 4;
		image_xscale = -1; //mirrors the original image
	}

	if keyboard_check(ord("D")){
		x = x + 4;
		image_xscale = 1; //sets image back to normal
	}

	if keyboard_check(ord("W")) y = y - 4;
	if keyboard_check(ord("S")) y = y + 4;
	
	
}
else if (sprite_index == spr_red_fox){		// movement for red fox origami
	
	if keyboard_check(ord("A")){
	x = x - 6;
	image_xscale = -1; 
	}

	if keyboard_check(ord("D")){
		x = x + 6;
		image_xscale = 1; 
	}

	if keyboard_check(ord("W")) y = y - 6;
	if keyboard_check(ord("S")) y = y + 6;

}

// check for collisions
if place_meeting(x, y, obj_Wall)
{
	if (sprite_index == spr_Player){
		if bbox_top < 64 y = 80;
		if bbox_bottom > room_height - 64 y = room_height - 80;
		if bbox_left < 64 x = 74;
		if bbox_right > room_width - 64 x = room_width - 73;
	}
	else if (sprite_index == spr_red_fox){
		if bbox_top < 64 y = 80;
		if bbox_bottom > room_height - 64 y = room_height - 80;
		if bbox_left < 64 x = 90;
		if bbox_right > room_width - 64 x = room_width - 90;
	}
}
else
{
	if bbox_left < 0
	    {
	    global.RoomGen_x -= 1;
	    var num = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);
	    RoomGen_SetMapEntry(num, "enter", 3); // Set to the RIGHT
	    room_restart();
	    }
	if bbox_right > room_width
	    {
	    global.RoomGen_x += 1;
	    var num = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);
	    RoomGen_SetMapEntry(num, "enter", 2); // Set to the LEFT
	    room_restart();
	    }
	if bbox_top < 0
	    {
	    global.RoomGen_y -= 1;
	    var num = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);
	    RoomGen_SetMapEntry(num, "enter", 1); // Set to the BOTTOM
	    room_restart();
	    }
	if bbox_bottom > room_height
	    {
	    global.RoomGen_y += 1;
	    var num = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);
	    RoomGen_SetMapEntry(num, "enter", 0); // Set to the TOP
	    room_restart();
	    }
}

// shoot
if (cooldown < 1) {
	
	if (keyboard_check(vk_right)) {
		if (global.Powerup1 == false){
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 0		//attack where the player was last seen
			}	
		} else{
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = -20		//attack where the player was last seen
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 0		//attack where the player was last seen
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 20		//attack where the player was last seen
			}
		}
		cooldown = 30;											//resets the cooldown to help reduce speed of projectiles being made
	}
	else if (keyboard_check(vk_left)) {
		
		if (global.Powerup1 == false){
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 180		
			}	
		} else{
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 160		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 180		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 200		
			}
		}
			
		cooldown = 30;
	}
	else if (keyboard_check(vk_up)) {
		if (global.Powerup1 == false){
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 90	
			}	
		} else{
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 70		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 90		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 110		
			}
		}
		cooldown = 30;
	}
	else if (keyboard_check(vk_down)) {
		if (global.Powerup1 == false){
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 270		
			}	
		} else{
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 250		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 270		
			}
			with(instance_create_layer(x,y,layer, obj_appr_basic_proj)){
				direction = 290		
			}
		}
		cooldown = 30;
	}
}

cooldown -= 1;	//help decrement the cooldown

global.Origami_cooldown -= 1;	//decrements the cooldown until we can use the transform again

if (global.Origami_cooldown <= 0){
	obj_Player.sprite_index = spr_Player;
}

//check for health of player
if (global.Player_health <= 0) {
	instance_destroy();			// if dead destroy instance
	game_restart();
}

