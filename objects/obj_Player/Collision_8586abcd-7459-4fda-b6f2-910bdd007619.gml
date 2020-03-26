	
if (damage_taken_cooldown <= 0){
	
	global.Player_health -= 2;
	audio_play_sound(snd_player_hurt, 1000, false);
		
	damage_taken_cooldown = 50;
	
}
	
damage_taken_cooldown -= 1;
