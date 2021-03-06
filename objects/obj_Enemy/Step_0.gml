if instance_exists(obj_Player) && sprite_index != spr_boss && sprite_index != spr_boss_2
{
	random_set_seed(date_current_datetime());	//randomizes seed so each step we can get a new number for our flag
	randomize();
	
	var spr_direction = irandom_range(1,4);
	//var spr_direction = 1;
	var move_stay = irandom_range(1,2);
	//var move_stay = 2;
	
	if move_stay == 1 and walk < 1{
		move_cooldown = 100;
	}
	
	if move_cooldown > 0 {
		speed = 0;	
	}
	else {
		speed = 2;	
	}
		
	if walk < 1 {
		if spr_direction == 1 {
			direction = 0;	
		}
		else if spr_direction == 2 {
			direction = 90;
		}
		else if spr_direction == 3 {
			direction = 180	
		}
		else if spr_direction == 4 {
			direction = 270;	
		}
		walk = 150;
	}
	
	move_cooldown -= 1;
	walk -= 1;
	
}


// check for collisions
if place_meeting(x,y, obj_Wall){
	
	if (sprite_index == spr_Goblin || sprite_index == spr_Cube){
		
		if bbox_top < 64  {
			y = 100;
			direction = 270;
		}
		if bbox_bottom > room_height - 64 {
			
			y = room_height - 100;
			direction = 180;
		}
		if bbox_left < 64 {
			x = 100;
			direction = 0;
		}
		if bbox_right > room_width - 64 {
			x = room_width - 110;
			direction = 90;
		}
		
	}
	
	
	
}

if (sprite_index == spr_Goblin || sprite_index == spr_Cube) {
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
			
			if (sprite_index == spr_Goblin){
				with(instance_create_layer(x,y,layer, obj_fireball_attack)){
					//attack where the player was last seen
					direction = point_direction(x,y,x_corr,y_corr);		
				}	
				
			}
			else if (sprite_index == spr_Cube){
				with(instance_create_layer(x,y,layer, obj_energyball_attack)){
					//attack where the player was last seen
					direction = point_direction(x,y,x_corr,y_corr);		
				}	
				
			}
			
			
		}
		//reset the attack cooldown so enemy is not always attacking
		attack_cooldown = 50;
	}
	//help decrement the cooldown
	attack_cooldown = attack_cooldown - 1;	
}

if sprite_index == spr_boss {
	
	if (laugh == true){
					
		audio_play_sound(snd_boss1_laugh, 1000, false);
		laugh = false;
					
	}
	
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

if sprite_index == spr_boss_2 {
	
	var cx = camera_get_view_x(view_camera[0]);
	var cy = camera_get_view_y(view_camera[0]);
	var cw = camera_get_view_width(view_camera[0]);
	var ch = camera_get_view_height(view_camera[0]);
	
	x = cw/2;
	y = ch/2;
	
	random_set_seed(date_current_datetime());	//randomizes seed so each step we can get a new number for our flag
	randomize();

	var attk_flag = irandom_range(1,5);
	
	if (attack_continuous > 0){
		attk_flag = 1;
	}

	//attack player
	if (attk_flag == 1 && attack_continuous > 0 ) {			//we can have this same setup for enemy movement towards player
	
		with(instance_create_layer(x,y,layer, obj_energyball_attack)){
		
			direction = point_direction(x,y, obj_Enemy.x_corr_point_1,obj_Enemy.y_corr_point_1);	
			
			if (obj_Enemy.y_corr_point_1 < 760 && obj_Enemy.x_corr_point_1 == 0) {
				obj_Enemy.x_corr_point_1 = 0;
				obj_Enemy.y_corr_point_1 += 10;
			}
			else if (obj_Enemy.y_corr_point_1 >= 760 && obj_Enemy.x_corr_point_1 <= 1015) {
				obj_Enemy.x_corr_point_1 += 10;
			}
			else if (obj_Enemy.y_corr_point_1 >= 10 && obj_Enemy.x_corr_point_1 >= 1015){
				obj_Enemy.y_corr_point_1 -= 10;
			}
			else if (obj_Enemy.y_corr_point_1 <= 0){
				obj_Enemy.x_corr_point_1 -= 10;
			}
		}	
		
		with(instance_create_layer(x,y,layer, obj_energyball_attack)){
			
			direction = point_direction(x,y, obj_Enemy.x_corr_point_2,obj_Enemy.y_corr_point_2);	
			
			if (obj_Enemy.y_corr_point_2 < 760 && obj_Enemy.x_corr_point_2 == 0) {
				obj_Enemy.x_corr_point_2 = 0;
				obj_Enemy.y_corr_point_2 += 10;
			}
			else if (obj_Enemy.y_corr_point_2 >= 760 && obj_Enemy.x_corr_point_2 <= 1015) {
				obj_Enemy.x_corr_point_2 += 10;
			}
			else if (obj_Enemy.y_corr_point_2 >= 10 && obj_Enemy.x_corr_point_2 >= 1015){
				obj_Enemy.y_corr_point_2 -= 10;
			}
			else if (obj_Enemy.y_corr_point_2 <= 0){
				obj_Enemy.x_corr_point_2 -= 10;
			}
		}	
		
		energy_ball_cooldown = 10;
	}
	else if (attack_cooldown < 1 && attk_flag == 2 || attack_cooldown < 1 && attk_flag == 3){
		var x_corr_player;
		var y_corr_player;
	
		with(obj_Player){
			x_corr_player = obj_Player.x;	//get x coord of player
			y_corr_player = obj_Player.y;	//get y coord of player
		}
	
		
		if (attk_flag == 2){		//if true then attack
		
			with(instance_create_layer(x,y,layer, obj_energyball_attack)){
				direction = point_direction(x,y,x_corr_player,y_corr_player);		//attack where the player was last seen				
			}	
		}
		else if (attk_flag == 3){		//if true then attack
			with(instance_create_layer(x,y,layer, obj_energyball_attack)){
				direction = point_direction(x,y,x_corr_player,y_corr_player);		//attack where the player was last seen
			}	
			with(instance_create_layer(x,y,layer, obj_energyball_attack)){
				direction = point_direction(x,y,x_corr_player+100,y_corr_player+100);		//attack where the player was last seen
			}
			with(instance_create_layer(x,y,layer, obj_energyball_attack)){
				direction = point_direction(x,y,x_corr_player-100,y_corr_player-100);		//attack where the player was last seen
			}
		}
		
		attack_cooldown = 30;
		total_attacks += 1
	}
	
	energy_ball_cooldown -= 1;
	attack_cooldown -= 1;	//help decrement the cooldown
	attack_continuous -= 1;	//help decrement the cooldown
	
	if (total_attacks > 15){
		total_attacks = 0;
		attack_continuous = 150;
	}
	
	
}


