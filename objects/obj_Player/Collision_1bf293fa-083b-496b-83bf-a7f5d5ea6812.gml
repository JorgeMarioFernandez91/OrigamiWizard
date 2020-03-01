
with(obj_life){
	instance_destroy();	
	global.Player_health += 5;
	if (global.Player_health > global.Max_health){
		global.Player_health = global.Max_health;	
	}
}
