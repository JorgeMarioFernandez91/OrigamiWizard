/* /////////////////////////////////////////////////////////////////////////////

Thank you for purchasing this asset! We hope that it will be of use to you...
However, before getting started, we should just go over a few things to explain
how the asset works.

Basically, the asset will create a DS grid that holds a number. This number is a 
"room". The asset will also create a DS list, and each entry in the list will hold 
a DS map which has the details about how the "room" should be set up.

So, say for example that you are in room 5. You would get the entry for position
"5" from the DS list - this will be a DS map ID - and then use the DS map functions 
on the returned map to get or set the required data.

The BASIC scripts set the following details in the DS map for each room:

 - the door positions for the "room" in the grid (will be "top", "bottom", "left" and "right")
 - the start position for the player to start the maze
 - the end position which is where we want the exit to be placed
 - the "entry" side for the room so that the player is created beside the correct door
 - whether the room has been visited or not
 
However the scripts are designed to be expanded upon so that you can add extra
data into each of the room maps, so that things like enemies, or pickups, or even 
just decoration can be stored easily and created as required. You can see examples
of this in the "DEMO ONLY" scripts and the object "obj_RoomGen_DEMO_Control", and 
you can see how it all holds together in the final room of the asset demo.

When impoting the asset into your project, ONLY IMPORT THE SCRIPTS as that is all
you need, and you can also delete the "RoomGen DEMO ONLY" scripts.

You'll find that each script comes with a LOT of comments, as we want you to 
understandexactly how the generation functions work so that you can later adapt 
them with the least fuss possible to your own projects.

Thanks again and have fun!

Mark Alexander - Nocturne Games

///////////////////////////////////////////////////////////////////////////// /*
 
