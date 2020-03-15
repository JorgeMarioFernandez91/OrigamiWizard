/// @description Draw Mini-Map

// This is essentially the debug script modified to be a mini-map.
// Note that we use the "visited" map entry that the PLAYER object
// adds to the map to decide whether to draw it or not...

var num = 0;
var res = 16;
var grid_w = ds_grid_width(global.RoomGen_grid)
var grid_h = ds_grid_height(global.RoomGen_grid)
var cur = RoomGen_GetRoomNumber(global.RoomGen_x, global.RoomGen_y);

draw_set_alpha(0.2);
draw_rectangle_colour(32, 32, 32 + (grid_w * res), 32 + (grid_h * res), c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
            
for (var j = 0; j < grid_h; j++;)
{
for (var i = 0; i < grid_w; i++;)
    {
    var _x = 32 + (i * res);
    var _y = 32 + (j * res);
    draw_set_alpha(0.2);
    draw_rectangle(_x, _y, _x + res, _y + res, true);
    draw_set_alpha(1);
    var _rm = RoomGen_GetRoomNumber(i, j);
    if _rm != -4
        {
        var m = global.RoomGen_list[| _rm];
        if m[? "visited"]
            {
            if m[? "end"] draw_circle_colour(_x + (res / 2), _y + (res / 2), res / 4, c_aqua, c_aqua, true);
            if m[? "start"] draw_circle_colour(_x + (res / 2), _y + (res / 2), res / 4, c_lime, c_lime, true);
            draw_set_alpha(0.2);
            draw_rectangle_colour(_x + (res / 10), _y + (res / 10), _x + res - (res / 10), _y + res - (res / 10), c_red, c_red, c_red, c_red, false);
            draw_set_alpha(1);
            draw_rectangle_colour(_x + (res / 10), _y + (res / 10), _x + res - (res / 10), _y + res - (res / 10), c_red, c_red, c_red, c_red, true);
            if m[? "top"] draw_circle_colour(_x + (res / 2), _y, res / 8, c_yellow, c_yellow, true);
            if m[? "bottom"] draw_circle_colour(_x + (res / 2), _y + res, res / 12, c_yellow, c_yellow, true);
            if m[? "left"] draw_circle_colour(_x, _y + (res / 2), res / 8, c_yellow, c_yellow, true);
            if m[? "right"] draw_circle_colour(_x + res, _y + (res / 2), res / 12, c_yellow, c_yellow, true);
            }
        if m[? "room"] == cur
            {
            draw_set_alpha(0.5);
            draw_rectangle_colour(_x + (res / 11), _y + (res / 11), _x + res - (res / 11), _y + res - (res / 11), c_lime, c_lime, c_lime, c_lime, false);
            draw_set_alpha(1);  
            draw_rectangle_colour(_x + (res / 10), _y + (res / 10), _x + res - (res / 10), _y + res - (res / 10), c_lime, c_lime, c_lime, c_lime, true);     
            }
        }
    }
}

