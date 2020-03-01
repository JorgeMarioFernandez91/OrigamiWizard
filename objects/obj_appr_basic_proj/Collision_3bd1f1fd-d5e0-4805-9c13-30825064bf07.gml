// check if projectile collided with other object
with (other){
	hp = hp - 1;
	if hp <= 0{ 
		
		random_set_seed(date_current_datetime());	//randomizes seed so each step we can get a new number for our flag
		randomize();

		var spawn_ = irandom_range(1,3);
		
		instance_destroy();
		//spawn item
		if (!instance_exists(obj_item_1) && global.Powerup1 == false){
			instance_create_layer(x,y,layer, obj_item_1);
		}
		
		if (spawn_ == 1){
			instance_create_layer(x,y,layer, obj_life);
		}
		
		if (sprite_index == spr_boss){
			show_debug_message("Exit Created!")
			instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Exit);
		
		}
		
		if (global.Origami_cooldown <= 0){
			
			global.Enemy_kills += 1;
			if (global.Enemy_kills >= 5){
				global.Origami_available = true;
				show_debug_message("CAN TRANSFORM")
			}
			
		}
		
		var curr_minute = date_current_datetime();

		var diff = date_second_span(global.time , curr_minute);

		show_debug_message("!!!!" + string(diff))
		
		
    }
}


//destroy projectile when it collides
instance_destroy();

// check if room is cleared of enemies, if so open door(s) to next room(s)
if !instance_exists(obj_Enemy){
	var rm = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);
	RoomGen_ClearMapEntry(rm, "enemy");
	with (obj_Door){
	    //if sprite_index == spr_RoomGen_DoorClosed_H {
		if sprite_index == spr_Closed_Door_H {
	        sprite_index = spr_Open_Door_H;
	        if image_yscale == 1{
	            with (instance_position(x - 32, y + 32, obj_Wall)) instance_destroy();
	            with (instance_position(x + 32, y + 32, obj_Wall)) instance_destroy();
	        }
	        else {
	            with (instance_position(x - 32, y - 32, obj_Wall)) instance_destroy();
	            with (instance_position(x + 32, y - 32, obj_Wall)) instance_destroy();
	        }
	    }
	    //if sprite_index == spr_RoomGen_DoorClosed_V{
		if sprite_index == spr_Closed_Door_V {
	        sprite_index = spr_Open_Door_V;
	        if image_xscale == 1 {
	            with (instance_position(x + 32, y - 32, obj_Wall)) instance_destroy();
	            with (instance_position(x + 32, y + 32, obj_Wall)) instance_destroy();
	        }
	        else{
	            with (instance_position(x - 32, y - 32, obj_Wall)) instance_destroy();
	            with (instance_position(x - 32, y + 32, obj_Wall)) instance_destroy();
	        }
	    }
    }
}


