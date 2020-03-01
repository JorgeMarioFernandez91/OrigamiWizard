
if (global.Enemy_kills >= 5 && global.Origami_cooldown <= 0){
	
	sprite_index = spr_red_fox;	//the sprite of the origami
	global.Enemy_kills = 0;	//count how many enemies killed
	global.Origami_cooldown = 150;	//the duration of transforming
	global.Origami_available = false;
}