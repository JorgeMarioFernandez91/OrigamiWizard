// check if projectile collided with other object (enemies)
with (other){
	
	
	audio_play_sound(snd_paper_hit, 1000, false);
					
	
	if (global.Powerup2 == false){
		hp = hp - 1;
	}
	else if (global.Powerup2 == true){
		hp = hp - 2;	
	}
	
	
	if hp <= 0{ 
		//randomizes seed so each step we can get a new number for our flag
		random_set_seed(date_current_datetime());	
		randomize();

		var spawn_ = irandom_range(1,5);
		instance_destroy();
		//spawn item/powerup
		if (!instance_exists(obj_item_1) && global.Powerup1 == false && spawn_ == 1){
			instance_create_layer(x,y,layer, obj_item_1);
		}
		else if (!instance_exists(obj_item_2) && global.Powerup2 == false && spawn_ == 2){
			instance_create_layer(x,y,layer, obj_item_2);
		}
		else if (spawn_ == 3 || spawn_ == 4){
			instance_create_layer(x,y,layer, obj_life);
		}
		//if boss is defeated create level exit
		if (sprite_index == spr_boss ){
			//show_debug_message("Exit Created!")
			audio_play_sound(snd_boss1_death, 1000, false);
			instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Exit);
		
		}
		else if (sprite_index == spr_boss_2 ){
			//show_debug_message("Exit Created!")
			audio_play_sound(snd_boss2_death, 1000, false);
			instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_Exit_2);
		
		}
		//check if transformation is available
		if (global.Origami_cooldown <= 0){
			//keep track of number of enemy kills
			global.Enemy_kills += 1;
			//if number of kills is greater or equal 5 then prompt to transform
			if (global.Enemy_kills >= 5){
				global.Origami_available = true;
			}
		}
		//keep track of ingame timer to later show the player their fastest time
		var curr_minute = date_current_datetime();
		var diff = date_second_span(global.time , curr_minute);
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


