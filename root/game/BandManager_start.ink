# title: BAND MANAGER v0.1
# author: 🎸 JON KEEVY 🎸
# theme: light
# font: system
# scenes_align: top
# toolbar: game_toolbar

// BAND MANAGER TEMPLATE
// VERSION 00.1
// CREATED by JON KEEVY....
// Functions & systems free to use, no credit required
// SET UP FOR Atrament Preact UI (distributed under MIT license. Copyright (c) 2023 Serhii "techniX" Mozhaiskyi.

/*

    This template is themed around a band going on tour. The player is the band manager and a performer. They must recruit bandmates and crew, invest in equipment, drive to the next stop on the tour - all while making enough money to keep going.
    
    Fail states: No money for fuel, no band, van breaks down.
    
    This template is a for an narrative game with mostly static NPCS. It assumes the player is going between different characters and locations. The missions can be trades, messages, investigations, etc.
    
    NPCs can be moved to new locations, or gathered for special scenes.
    Most conversations assume the Player is speaking with one NPC, but adding a companion won't take too much tweaking.
 
// >>>>>>>>>>>>>> TO DO <<<<<<<<<<<<<<<<<
// [X] Travel and fuel consumption calculator
// [X] Town tracker
// [X] Gig income generator
// [X] Tour Goal - SHITFIRE FEST.
// [X] this should be a countdown
// [X] The Van - space limits
// [X] Recruit / Replace / Remove Band members
// [X] Band Npc generator
// [X] Rehearse to improve bandsound
// [X] Auditions reduce bandsound
// [ ] Gear deteriate
// [ ] Gear improve
// [ ] NPC deteriate
// [ ] NPC recover
// [X] Time as resource management - Action Pool
// [X] Band Mate Modifiers
// [ ] Band Mate mods WORK
// [ ] Gig performance HEAT
// [X] Alternative Income
// [ ] Cop radar
// [ ] Fans
// [ ] Venue Managers
// [ ] Events / Opportunities
// [ ] CRED / RESPECT
// [O] Debug Mode
// [O] Show Hints Mode
// [X] Sound effects stings
// [X] Currency variable
*/


// ............ INCLUDED FILES ..............
INCLUDE BM_intro.ink
INCLUDE BM_Functions.ink
INCLUDE BM_Variables.ink
INCLUDE BM_MoneyTravelTime.ink
INCLUDE BM_Auditions.ink
INCLUDE BM_PlayGig.ink
INCLUDE BM_SFXsorter.ink
INCLUDE BM_toolbar.ink

// ............ DEBUG VARIABLES ............
VAR DEBUG = false
VAR showToolbar = false
VAR showHints = false
VAR testNPC = ()

// ............ START DIVERT ............
-> debugMenu
=== debugMenu
    <br>
    <br>
{printFanbase()}
    [bg]IMAGES/1920x1080.jpg[/bg]    
    [img]IMAGES/1920x1080.jpg[/img]
    in line
    <br>
    //#BACKGROUND: IMAGES/1080x1920.jpg
    <br>
    [banner style=accent]This game is under development.[/banner]
    <br>
    <center><big>It contains sound effects.
    <center><big>You can adjust the volume at any time via the menu.</>
    
    
    + [Play Game in Debug Mode]
        ~ DEBUG = true
        ~ showToolbar = true
        ~ SEED_RANDOM(205)
        Debug Mode active. Random Seed is Locked.
        // # PLAY_SOUND: SOUNDS/showdown-sting-99978.mp3
        [info side=highlight]Special options will show in menus. Explainers like this will be visible. Randomised functions will generate the same output every run.[/info]
        ->debugNavigation
    + [Play Game in Normal Mode] 
        ~ DEBUG = false
- (onward)
#CLEAR
-> Introduction
// Ink gets funky if the starting divert isn't up top

=== debugNavigation
Debug: Go to...
    + [Introduction]    -> Introduction
    + [Do Stuff]        -> SpendTime
    + [Hit the Road]    -> HittheRoad
