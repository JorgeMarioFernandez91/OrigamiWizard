// draw player shadows

with (obj_Player)
{
draw_sprite_ext(sprite_index, image_index, x + 5, y + 10, 1, 1, image_angle, c_black, 0.25);
}
with (obj_Bullet)
{
draw_sprite_ext(sprite_index, image_index, x + 15, y + 20, 1, 1, image_angle, c_black, 0.25);
}
with (obj_Enemy)
{
draw_sprite_ext(sprite_index, image_index, x + 5, y + 10, 1, 1, image_angle, c_black, 0.25);
}

// draw instructions in the first room
if (show_instruction == true){
	
	// get the dimensions of the room
	var cw = camera_get_view_width(view_camera[0]);
	var ch = camera_get_view_height(view_camera[0]);
	
	// make the instructions in the first room black
	draw_text_colour(cw/3-200, ch/2 - 200, "Move with WASD", c_black, c_black, c_black, c_black, 1);
	draw_text_colour(cw/3-200, ch/2 - 100, "Shoot with Arrow Keys", c_black, c_black, c_black, c_black, 1);
	draw_text_colour(cw/3-200, ch/2, "Press Space to Transform", c_black, c_black, c_black, c_black, 1);
	
}

