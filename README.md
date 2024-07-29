# Bonk-a-Dodge

This was a graded university project. The commit history has been altered for the publication on GitHub.

The task was to create a simple video game that is both visually appealing and uses sound effects and music
to enhance the gameplay experience.

The game itself had to be implemented using [Processing](https://processing.org).
The sound effects and music had to be played by a [Max](https://cycling74.com/products/max) patch.
Communication between the Processing program and the Max patch had to be performed
using the Open Sound Control protocol.

The Max patch has been excluded from the commit history, as it contained sensitive information
and audio data from foreign sources.

As such, the game will not have any sound effects or music if one attempts to play it with the
available files.

If you are curious about the sound effects/music that were used or wish to rebuild the experience I intended:

* sound effects
  * the "BONK" sound effect that is known through various memes (plays when hitting a positive target)
  * a brief dog howl (plays when hitting a negative target)
  * a "swoosh" sound of a bat being swung through the air (plays when clicking without hitting a target)
* music
  * ["Run Amok" by Kevin MacLeod](https://incompetech.com/music/royalty-free/music.html) (played during gameplay rounds)
  * ["Local Forecast" by Kevin MacLeod](https://incompetech.com/music/royalty-free/music.html) (played outside of gameplay rounds, as a menu theme)

## Requirements

In order to be able to run the Processing program, you need

* [Processing](https://processing.org/download)
* the oscP5 library for Processing (can be found and installed in Processing via Tools -> Manage Tools... -> Libraries)
