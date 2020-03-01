draw_self();

if (restart == true){
	
	if (diff == 0){
		var curr_minute = date_current_datetime();
		diff = date_second_span(global.time , curr_minute);
	}	
	
	draw_text(obj_Exit.x-200, obj_Exit.y - 200, "Completion Time: " + string(diff) + " seconds!");
	draw_text(obj_Exit.x-200, obj_Exit.y - 100, "Game Over Press Esc to Restart");
	
	if (keyboard_check_pressed(vk_escape)){
		game_restart();
		RoomGen_CleanUp();
	}

}
