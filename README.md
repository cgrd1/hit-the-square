# Hit the square

## Description:
**Hit the square** is a small-scope 2D game implemented in Lua and Love2D where your objective is to hit a moving square in the screen.

## Usage:

With Love2D running on your local machine, open the game by entering `love .` at your terminal window, making sure to enter the command after moving into
the game directory via `cd hit-the-square`

A game screen should now appear and you should be able to see a "score" that starts at 0, as well as a "container" inside of which the actual game takes place and where you can find your character, represented by a ball.

To start the game, press the ENTER key and notice how your character starts falling, as it falls, you can (and should) use your "a" and "d" keys to move your character accordingly, aiming to hit the enemy (the square) as it moves side by side aswell.

The game will then increase its difficulty by incrementing the character's speed every time you successfully hit the square and your score increases by one point.

Finally, the game ends when you miss the square and hit the floor of the container instead.

## Contents of the project:

**Hit the square** is comprised of four different files:

`main.lua` -> This is the main file that runs the game, it contains the logic for its proper functionality.

`collision.wav` -> Generated using `Bfxr`, the purpose of this audio file is to let you know that you have successfully increased your score by hitting the square.

`floor_collision.wav` -> Generated using `Bfxr`, the purpose of this audio file is to let you know that the game has ended because of colliding with the container floor.

`README.md` -> Provides an overview of the game.

## Design choices:

**The following section discusses the implementation of the game and does not contain any relevant information about its usage or installation.**

`main.lua:`

When the user runs the game, several properties of the game are loaded in the `love.load` function such as the game title, the character and the enemy properties with a randomly assigned enemy direction that decides its initial movement, as well as other variables that defines the player's score, the collision sounds and a boolean value that decides when to stop the main game loop from executing.

Afterwards, there are three function definitions that helps the implementation of the game, `checkCollision`, `resetCharacter` and `characterHitsFloor`. These functions take care of core aspects of the game such as collision detection and resetting the character position once a point is earned.

Below these functions and after setting the ENTER key to start the game, we find the `love.update` function, which takes care of checking for a valid game state through the statement "if not gameOver", inside of which we can find the implementation of both the character and the enemy movement, as well as displaying the appropiate sounds when a collision is detected between either the character and the enemy or the character and the floor, updating the score and increasing the character's speed accordingly.

Finally, we can find the function `love.draw`, which takes care of properly displaying both the character and the enemy's shape, as well as displaying via lines a container whithin which the game actually takes place, with the final addition of displaying the player's score as it increases.