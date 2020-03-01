// check if projectile collided with player
with (other){	
	hp = hp - 1;	

	global.Player_health -= 1;	

}

//destroy projectile when it collides
instance_destroy();