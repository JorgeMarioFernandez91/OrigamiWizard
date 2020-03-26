// check if projectile collided with player
with (other){	
	hp = hp - 1;	

	global.Player_health -= 1;	
	audio_play_sound(snd_player_hurt, 1000, false);


}

//destroy projectile when it collides
instance_destroy();