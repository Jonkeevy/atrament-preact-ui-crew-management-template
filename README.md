# Atrament Preact UI

`atrament-preact-ui` is a web application to run Ink games.

It uses [inkjs](https://github.com/y-lohse/inkjs) to interpret Ink scripts, [Atrament](https://github.com/technix/atrament-core) as a game engine, and [Preact](https://preactjs.com/) as a Web UI framework.

[Live Demo](https://technix.github.io/atrament-preact-ui/)

## Getting started

### Get source code and install dependencies

```
git clone https://github.com/technix/atrament-preact-ui.git
cd atrament-preact-ui
npm install
```

### Run application locally in dev mode
```
npm start
```

The application is available at `http://localhost:8900`. If any source file (Ink or Javascript) is edited, the application automatically restarts with these changes.

### Build application for publishing to web
```
npm run build
```

The standalone web application files will be in `build` folder.

## Create your own game with Atrament Preact UI

1. Remove all files from `src/assets/game` and put your game files there (ink script, images, music etc).
2. Edit `atrament.config.json`, change the following parameters in `game` section:
    * `source`: your main Ink file name
    * `script`: desired compiled Ink file name (JSON extension is mandatory)
3. You may also change default configuration in `atrament.config.json`:
    * "`theme`": "`light`", "`sepia`", or "`dark`"
    * "`font`": "`System`", "`Fira Sans`", "`Lora`", "`Merriweather`", or "`OpenDyslexic`"
4. (optionally) edit `src/manifest.json` and change `name` and `short_name` parameters.
5. That's it! You can make a test run with `npm start`, or build standalone web app with `npm run build`.

## Ink tags handled by Atrament Preact UI

### Global tags

| Tag | Description                |
| :-------- | :------------------------- |
| `# title: A Story Written In Ink` | Game title |
| `# author: John Doe` | Author |
| `# theme: light` | Game color theme: `light`, `sepia`, or `dark` |
| `# font: System` | Game font: `System`, `Fira Sans`, `Lora`, `Merriweather`, or `OpenDyslexic` |
| `# observe: varName` | Register variable observer for `varName` Ink variable. Variable value is available in `vars` section of Atrament state. |
| `# autosave: false` | Disables autosaves. |
| `# single_scene` | Store only last scene in Atrament state. |
| `# scenes_align: center` | Scene alignment on the screen. Can be set to `top`, `center`, or `bottom`. |
| `# hypertext` | Use links instead of choices. See "[Hypertext mode](#hypertext-mode)". |
| `# toolbar: toolbar_function` | Use output of this function as a toolbar content. |

### Knot tags
| Tag | Description                |
| :-------- | :------------------------- |
| `# IMAGE: some/picture.jpg` | Show image before paragraph text. |
| `# CLEAR` | Clear scenes list before saving current scene to Atrament state. |
| `# AUDIO: sound.mp3` | Play sound (once). |
| `# AUDIOLOOP: music.mp3` | Play music (looped). |
| `# AUDIOLOOP: false` | Stop playing music. |
| `# PLAY_SOUND: sound.mp3` | Play sound (once). |
| `# STOP_SOUND: sound.mp3` | Stop playing specific sound. |
| `# STOP_SOUND` | Stop playing all sounds. |
| `# PLAY_MUSIC: music.mp3` | Play background music (looped). |
| `# STOP_MUSIC: music.mp3` | Stop playing specific background music. |
| `# STOP_MUSIC` | Stop playing all background music. |
| `# CHECKPOINT` | Save game to 'default' checkpoint. |
| `# CHECKPOINT: checkpointName` | Save game to  checkpoint `checkpointName`. |
| `# SAVEGAME: saveslot` | Save game to `saveslot`. |
| `# RESTART` | Start game from beginning. |
| `# RESTART_FROM_CHECKPOINT` | Restart game from latest checkpoint. |
| `# RESTART_FROM_CHECKPOINT: checkpointName` | Restart game from named checkpoint. |

Note: For sound effects, please use either AUDIO/AUDIOLOOP or PLAY_SOUND/PLAY_MUSIC/STOP_SOUND/STOP_MUSIC tags. Combining them may lead to unexpected side effects.


## Hypertext mode

When global tag `hypertext` is set, Atrament UI switches to hypertext mode. In this mode choice options are not displayed. However, author can use `[link=target choice text]link text[/link]` to link specific phrases to scene choices.

For better use experience in hypertext mode authors can set global tags `single_scene` and `scenes_align: top`.

```
# hypertext
# single_scene
# scenes_align: top

You are standing in an open field west of a white house, with a boarded [link=Open door]front door[/link]. There is a [link=Examine mailbox]small mailbox[/link] here.

+ [Examine mailbox] -> examine_mailbox
+ [Open door] -> inside_house
```

## Custom markup
| Markup | Description                |
| :-------- | :------------------------- |
| `[img]path/to/image.jpg[/img]` | Display inline image. |
| `[button=function]Text[/button]`<br>`[button onclick=function]Text[/button]` | Display button, call a function when clicked. If function returns text, it will be displayed as a new overlay content. If not, existing overlay content will be updated.<br>Attributes:<br>`onclick=function` function to be called when clicked.<br>`disabled=true` disables the button<br>`bordered=false` hide button borders |
| `[link=target choice text]Text[/link]` | Creates a link. When clicked, the target choice is activated, and game continues. |
| `[progress value={variable}]Inner text[/progress]` | Displays progress bar.<br>Attributes:<br>`value=x` current progressbar value<br>`min=x` minimal progressbar value<br>`max=x` maximal progressbar value<br>`style=accent` highlight progressbar with accent theme color |
| `[input var=variable]` | Input element, sets value of given variable. Default value of this field is read from the same variable. Disabled on inactive scenes. <br>Attributes:<br>`var=n` variable name to change<br>`type=number` input type. Possible values: `text`, `number`.<br>`placeholder=text` placeholder text |
| `[spoiler]text[/spoiler]` | Hidden text. Clicking it toggles text visibility. |
| `[info]text[/info]` | Display text as an information block. Since this is a block element, it is recommended to use it on a whole paragraph.<br>Attributes:<br>`font=system` use system font<br>`side=n` add color to the left infobox side. Possible values: `highlight`, `accent`. |

Note: it is not possible to wrap multiple paragraphs with these tags. Use &lt;br&gt; tag for line breaks if you need multiline text in tags.

## Overlay

Atrament UI can display custom data (inventory, character stats etc.) as an overlay. 

To display an overlay, you need to define a button in the toolbar or in the game content with the `[button]` tag. If the function returns text content, it will be displayed as an overlay. Overlay content can have buttons too.

If the first line of the function is a `[title]Overlay Title[/title]` tag, this title will be displayed in the toolbar.

Example of toolbar and overlays:
```
# toolbar: game_toolbar

...

=== function game_toolbar()
  [button=inventory]Inventory[/button]
  [button=stats]Stats[/button]

=== function inventory()
  [title]Inventory[/title]
  You are carrying:
  ...

=== function stats()
  [title]Character: {character_name}[/title]
  Health: {health}
  ...

```


## Atrament repositories

- [atrament-web](https://github.com/technix/atrament-web)
- [atrament-core](https://github.com/technix/atrament-core)

See also [Atrament core documentation](https://github.com/technix/atrament-core/blob/master/README.md) for additional info on Atrament API.

## LICENSE

Atrament is distributed under MIT license.

Copyright (c) 2023 Serhii "techniX" Mozhaiskyi
