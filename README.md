Coin Collector - Isometric Test
===============================

This game / project is or was never intended to be a fully playable game, nor make the game mechanics any sense; its just a personal project to play around with the engine and to see how I like or dislike game development. This is what I came up with and I want to share it with you.


Key Features
------------
- Isometric 2D Game
<img src="https://i.imgur.com/042uWXA.gif"/>

- Main Menu
<img src="https://i.imgur.com/xtwbhlA.gif"/>

- Savegame Selection Map
<img src="https://i.imgur.com/T5VOttg.gif"/>

- Overview / World Map
<img src="https://i.imgur.com/Wytc47A.gif"/>

- Music and Sound Effects
- 2D Animations
- runs with Godot 4.1


Known Issues
------------
There are still some parts / issues I wasn’t able to handle so far:

- It seems the subviewport for the savegame selection map, which projects the 3D Label into the 2D World uses the same texture.
- Within the Overview Map I use Area2D for the pads, to check if the player is standing on the pad. If so, the ui is updated. Unfortunately I’ll get some flickering with the ui, cause, body_entered signal is called more the once.
- I tried to use y-sort for the tilemap. Somehow the usage wasn’t that plausible for me. There are still some “cliping” problems, if the player comes close to an edge of a tileset.
- For the pads I used to export a kind of complex data structure; an dictionary with an key as input names and values as a array index; two arrays which have on the index of the dictionary the path to follow and on the other arrays index if the path is backward or forward. I hope this [PR](https://github.com/godotengine/godot/pull/48201) will make this a lot easier.


Credits
------------
I’m no designer, so I mainly used free assets from around the internet.
| What                      | Link           |
| ------------------------- |----------------|
| Isometric Tileset Kenney  | https://www.kenney.nl/assets/isometric-miniature-prototype |
| Player Model              | https://erikari.itch.io/elements-supremacy-assets      |
| Coin Icon UI              | https://icons8.de/icon/Bnal8CzCxL55/coin     |
| Stopwatch Icon UI         | https://icons8.de/icon/12999/zeit |
| Coin Isometric            | https://www.shutterstock.com//de/image-vector/coin-lowpoly-perspective-3d-animation-sprite-510834247     |
| Title Image               | https://de.cooltext.com   |
| Music & Sound effects <br> by Eric Matyas |   https://soundimage.org  |
