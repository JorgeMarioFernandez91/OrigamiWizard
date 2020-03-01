var dir = point_direction(x, y, other.x, other.y);

while(place_meeting(x, y, other))
{
with (other)
    {
    x += lengthdir_x(0.5, dir);
    y += lengthdir_y(0.5, dir);
    }
x -= lengthdir_x(0.5, dir);
y -= lengthdir_y(0.5, dir);
}


