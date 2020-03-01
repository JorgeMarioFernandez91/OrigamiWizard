if instance_exists(obj_Player) && sprite_index != spr_boss
{
	var dir = point_direction(x, y, obj_Player.x, obj_Player.y);
	image_angle += clamp(angle_difference(dir, image_angle), -10, 10);
	direction = image_angle;
	speed = spd;
	if sprite_index == spr_RoomGen_Demon
	    {
	    if point_distance(x, y, obj_Player.x, obj_Player.y) < 256
	        {
	        direction = image_angle + 180;
	        }
	    if alarm[0] < 0
	        {
	        with (instance_create_layer(x, y, "Instances", obj_Bullet))
	            {
	            direction = other.image_angle;
	            }
	        alarm[0] = room_speed;
	        }
	    }
}

if sprite_index == spr_Goblin {
	//randomizes seed so each step we can get a new number for our flag
	random_set_seed(date_current_datetime());	
	randomize();
	//chance that enemy will attack
	var attk_flag = irandom_range(1,2);
	//attack player
	if (attack_cooldown < 1) {
		var x_corr;
		var y_corr;
		//get the player object
		with(obj_Player){
			x_corr = obj_Player.x;	//get x coord of player
			y_corr = obj_Player.y;	//get y coord of player
		}
	
		if (attk_flag == 1){		//if true then attack
			with(instance_create_layer(x,y,layer, obj_fireball_attack)){
				//attack where the player was last seen
				direction = point_direction(x,y,x_corr,y_corr);		
			}	
		}
		//reset the attack cooldown so enemy is not always attacking
		attack_cooldown = 50;
	}
	//help decrement the cooldown
	attack_cooldown = attack_cooldown - 1;	
}

if sprite_index == spr_boss {
	
	random_set_seed(date_current_datetime());	//randomizes seed so each step we can get a new number for our flag
	randomize();

	var attk_flag = irandom_range(1,5);
	var move_flag = irandom_range(1,5);

	//attack player
	if (attack_cooldown < 1) {			//we can have this same setup for enemy movement towards player
	
		var x_corr_player;
		var y_corr_player;
		
		var x_corr_boss;
		var y_corr_boss;
	
		with(obj_Player){
			x_corr_player = obj_Player.x;	//get x coord of player
			y_corr_player = obj_Player.y;	//get y coord of player
		}
	
		show_debug_message(y_corr_player);
		
		if (attk_flag == 1){		//if true then attack
		
			with(instance_create_layer(x,y,layer, obj_fireball_attack)){
				direction = point_direction(x,y,x_corr_player,y_corr_player);		//attack where the player was last seen				
			}	
		}
		else if (attk_flag == 2){		//if true then attack
			with(instance_create_layer(x,y,layer, obj_fireball_attack)){
				direction = point_direction(x,y,x_corr_player,y_corr_player);		//attack where the player was last seen
			}	
			with(instance_create_layer(x,y,layer, obj_fireball_attack)){
				direction = point_direction(x,y,x_corr_player+100,y_corr_player+100);		//attack where the player was last seen
			}
			with(instance_create_layer(x,y,layer, obj_fireball_attack)){
				direction = point_direction(x,y,x_corr_player-100,y_corr_player-100);		//attack where the player was last seen
			}
		}
		
		attack_cooldown = 30;
		move_cooldown += 10;
	}
	else if (move_cooldown < 1) {
		
		x_corr_boss = obj_Enemy.x;
		y_corr_boss = obj_Enemy.y;
		
		var cx = camera_get_view_x(view_camera[0]);
		var cy = camera_get_view_y(view_camera[0]);
		var cw = camera_get_view_width(view_camera[0]);
		var ch = camera_get_view_height(view_camera[0]);
		
		if (move_flag == 1){
			x = cw/2 - 40;
			y = ch/2 - 50;
			//show_debug_message("CENTER");
		}
		else if (move_flag == 2) {
			x = cx;
			y = cy;
			//show_debug_message("TOP LEFT");	
		}
		else if (move_flag == 3){
			x = cw - 120;
			y = cy;
			//show_debug_message("TOP RIGHT");	
		}
		else if (move_flag == 4){
			x = cx;
			y = ch - 120;
			//show_debug_message("BOTTOM LEFT");	
		}
		else if (move_flag == 5){
			x = cw - 120;
			y = ch - 120;
			//show_debug_message("BOTTOM RIGHT");	
		}
		move_cooldown = 75;
	}
	move_cooldown -= 1;
	attack_cooldown -= 1;	//help decrement the cooldown
}