
var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
var cw = camera_get_view_width(view_camera[0]);

draw_set_font(fnt_player_health);
// divide by 2 to get half of the width

if (global.Origami_available == true){
	
	draw_text(cw/4 + 200, cy+25, "Transformation Available");
	
}
else{
	
	draw_text(cw/4 + 300, cy+25, "Transformation Cooling Down");
	
}

