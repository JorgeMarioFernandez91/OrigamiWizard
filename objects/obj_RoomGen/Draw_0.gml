//RoomGen_Draw_Debug(48, true);

// Draw the generated grid for debugging
if (draw == true){
	
	draw_set_alpha(0.75);
	draw_rectangle_colour(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);

	RoomGen_Draw_Debug(res, true);

	var _str = "";
	repeat(room_num)
	    {
	    _str += ".";
	    }
	draw_text(32, 32, string_hash_to_newline("Generating" + _str));

}
