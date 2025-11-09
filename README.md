# colorpetcube
Displays a 3d rotating color cube using text mode on the Commodore 64

Pet Color Cube v0.1

Trying to plot a 3d-cube with different line colors to the text screen.
Also includes a z-buffer to make it look even better, but will ofcouse take longer time to calculate.
Since you have to clear the z-buffer for each frame (1000 bytes), and also check each colorsquare for distance.

Got it working in good old Commodore 64 BASIC v2, its slow, like very slow.
So to see it in real time, i saved each frame to disk.
This is something i would have run over night back in the 80s.
Let the computer create the data, falling asleep to the occasional disk writing :)
Check how slow it is in the first video.

So i precalculated 100 frames. Using 1 byte for 2 colorsquares.
Thats 500 bytes for a screenful of color-memory.
Used that data with a small asm decoder.
That takes 200 blocks (50kb). So let exomizer compress it down to 28 blocks.
Check the final result in the 2nd video.
The decoder is slowed down a bit. Could go 8 times faster. 



Now.. to compress the frames with RLE?
