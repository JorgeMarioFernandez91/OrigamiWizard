/// @function				RoomGen_Draw_Debug(res, nums)
/// @param	{int)	res		The grid resolution (ie: how many pixels to s side of each grid square)
/// @param  {bool}	nums	Whether to draw the room numbers or not

/// @description			This script is simply for drawing the output of the global room 
///							grid to the screen. It draws the total grid, each room in the grid,
///							all doors for each room and the start and end points. If you edit 
///							the room maps to hold more data (like enemies, power ups, pickups, 
///							etc...), then you can edit this script to show them easily.

var num = 0;
var res = argument0;
var grid_w = ds_grid_width(global.RoomGen_grid)
var grid_h = ds_grid_height(global.RoomGen_grid)

for (var j = 0; j < grid_h; j++;)
{
for (var i = 0; i < grid_w; i++;)
    {
    var _x = (room_width / 2) - ((grid_w * res) / 2) + (i * res);
    var _y = (room_height / 2) - ((grid_h * res) / 2) + (j * res);
    draw_set_alpha(0.2);
    draw_rectangle(_x, _y, _x + res, _y + res, true);
    draw_set_alpha(1);
    var _rm = RoomGen_GetRoomNumber(i, j);
    if _rm != -4
        {
        var m = global.RoomGen_list[| _rm];
        if m[? "end"] draw_circle_colour(_x + (res / 2), _y + (res / 2), res / 3, c_aqua, c_aqua, false);
        if m[? "start"] draw_circle_colour(_x + (res / 2), _y + (res / 2), res / 3, c_lime, c_lime, false);
        draw_set_alpha(0.3);
        draw_rectangle_colour(_x + (res / 10), _y + (res / 10), _x + res - (res / 10), _y + res - (res / 10), c_red, c_red, c_red, c_red, false);
        if argument1
            {
            var _s = string(m[? "room"]);
            var _sx = _x + (res / 2) - (string_width(string_hash_to_newline(_s)) / 2);
            var _sy = _y + (res / 2) - (string_height(string_hash_to_newline(_s)) / 2);
            draw_text(_sx, _sy, string_hash_to_newline(_s));
            }
        draw_set_alpha(1);
        draw_rectangle_colour(_x + (res / 10), _y + (res / 10), _x + res - (res / 10), _y + res - (res / 10), c_red, c_red, c_red, c_red, true);
        if m[? "top"] draw_circle_colour(_x + (res / 2), _y, res / 8, c_blue, c_blue, true);
        if m[? "bottom"] draw_circle_colour(_x + (res / 2), _y + res, res / 12, c_yellow, c_yellow, true);
        if m[? "left"] draw_circle_colour(_x, _y + (res / 2), res / 8, c_blue, c_blue, true);
        if m[? "right"] draw_circle_colour(_x + res, _y + (res / 2), res / 12, c_yellow, c_yellow, true);
        }
    }
}
