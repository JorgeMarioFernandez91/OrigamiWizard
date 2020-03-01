/// @function						RoomGen_Cover_Doors(layer, sprite, image_index, top_width, top_height, colour);
///	@param	{id}	layer			The asset layer to create the door cover sprite on
///	@param	{id}	sprite			The sprite to use as the door cover
///	@param	{int}	image_index		The sprite to use as the door cover
///	@param	{real}	x				The x position to place the cover at
///	@param	{real}	y				The y position to place the cover at
///	@param	{real}	colour			The blend colour (use c_white to leave the sprite "as-is")

///	@description					This script is for placing the "door cover" sprites to cover the areas of a 
///									room that you don't want the player to be able to exit from. The funtion will 
///									return the ID of the sprite element being added, or -1 if it fails.

var _layer = argument0;
if is_string(_layer)
{
var _layer = layer_get_id("Sprite_Walls");
}

if !layer_exists(_layer)
{
show_debug_message("RoomGen_Cover_Doors: ERROR! Layer doesn't exist!");
return -1;
}

var _sprite = layer_sprite_create(_layer, argument3, argument4, argument1);
layer_sprite_index(_sprite, argument2);
layer_sprite_blend(_sprite, argument5);
layer_sprite_speed(_sprite, 0);

return _sprite;