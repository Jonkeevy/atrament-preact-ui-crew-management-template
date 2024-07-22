
// BAND MANAGER FUNCTIONS
// VERSION 00.1
// CREATED by JON KEEVY.... free to use, no credit required
// SET UP FOR Atrament Preact UI (distributed under MIT license. Copyright (c) 2023 Serhii "techniX" Mozhaiskyi.
// https://github.com/technix/atrament-preact-ui


// ............ FUNCTIONS & CHECKS .........
=== function printHELLO
    HELLO

=== RandomBar
{~bar1|bar2|bar3|bar4|bar5}
//{printAlts:->RandomBar->} 
->->

=== function came_from(-> x)
    ~ return TURNS_SINCE(x) == 0

=== function alter(ref x, k) ===
    ~ x = x + k

=== function filter(var, type)
    ~ return var ^ LIST_ALL(type)

=== function improve(ref list)
    {
    -list != LIST_MAX(LIST_ALL(list)):
        ~ list ++
        ~ return list
    - else:
        ~ return list
    }

=== function reduce(ref list)
    {
    -list != LIST_MIN(LIST_ALL(list)):
        ~ list --
        ~ return list
    - else:
        ~ return list
    }

// ............ GRAMMAR 
=== function isAre(list)
    {LIST_COUNT(list) == 1:is|are}
    
=== function plural(list)
    {LIST_COUNT(list) > 1:s}

=== function article(list)
    {LIST_COUNT(list) == 1:a }

=== function listWithCommas(list, if_empty)
    {LIST_COUNT(list):
    - 2:
            {LIST_MIN(list)} and {listWithCommas(list - LIST_MIN(list), if_empty)}
    - 1:
            {list}
    - 0:
            {if_empty}
    - else:
            {LIST_MIN(list)}, {listWithCommas(list - LIST_MIN(list), if_empty)}
    }



// ............... SKILLS AND INSTRUMENTS

=== function bandhas(x)
    ~ return x ^ band
    // VERY useful for checking if the band has eg a Negotiator.

=== function whoPlays(x)
    {
    - x == instrument(npc01):
        ~ return name(npc01)
    - x == instrument(npc02):
        ~ return name(npc02)
    - x == instrument(npc03):
        ~ return name(npc03)
    - x == instrument(npc04):
        ~ return name(npc04)
    - x == instrument(npc05):
        ~ return name(npc05)
    - else:
        no one
    }

=== function playsWhat(x)
    {
    - x == name(npc01):
        ~ return instrument(npc01)
    - x == name(npc02):
        ~ return instrument(npc02)
    - x == name(npc03):
        ~ return instrument(npc03)
    - else:
        nothing
    }

=== function whatsbusted()
    {
    - busted == condition(npc01):
        ~ return instrument(npc01)
    - busted == condition(npc02):
        ~ return instrument(npc02)
    - busted == condition(npc03):
        ~ return instrument(npc03)
    - else:
        nothing
    }

=== function whosbusted()
    {
    - busted == condition(npc01):
        ~ return name(npc01)
    - busted == condition(npc02):
        ~ return name(npc02)
    - busted == condition(npc03):
        ~ return name(npc03)
    - else:
        no one
    }

=== function whosskill(x)
    {
    - x == skill(npc01):
        ~ return name(npc01)
    - x == skill(npc02):
        ~ return name(npc02)
    - x == skill(npc03):
        ~ return name(npc03)
    - x == skill(npc04):
        ~ return name(npc04)
    - x == skill(npc05):
        ~ return name(npc05)
    - else:
        no one
    }

=== function OddJob()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1) + RANDOM(1,99))
    ~ tour_fund += income
    {currency} {income}

=== function negotiate()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1))
    ~ tour_fund += income
    {currency} {income}

=== function PettyCrime()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1) + RANDOM(100,500))
    ~ tour_fund += income
    {currency} {income}

=== function printNegotiateIncome(x)
    {currency} {negotiate()}

 
    
=== check_Finished_Tour
    {
        //-LIST_COUNT(towns) == 0:
        - not towns:
        Winner
        ->Winner
    }
->->

=== check_Broke 
{
- tour_fund < 20:
    ->GetCreative
}
->->

=== cont_Button
+ [🤘 LET'S GO! 🤘] #PLAY_SOUND: SOUNDS/old-radio-button-click-97549.mp3
#CLEAR
-
->->

=== countDown
#CLEAR
<br>
<br>
<br>
# PLAY_SOUND: SOUNDS/electric-guitar-metal-riff-107087.mp3
<center><big><big><big><big><big>SHITFIRE FEST</>
<center><big><big><big>IN</>
<center><big><big><big><big><big>{days_remaining} DAYS</>
#CLEAR  
+ [🤘 HELL YEAH 🤘]
{days_remaining<1:-> ShitFire_Fest}
-->->

=== NPCexplainer
#CLEAR
When you recruit a band member the following occurs:
The Band's performance gets worse BUT your heat improves, rehearse to improve and capitalise on the multiplier.
HEAT is a multiplier of your performance. When you rock it increases the benefits.
Instrument types are cosmetic, but the condition matters. Every gig and rehearsal has a chance of degrading the instruments. A musician with a BUSTED instrument can't perform. HARDCORE instruments contribute to HEAT.
Every band member has a skill and a vice.
SKILLS bring benefits to the whole band. e.g. a GEARHEAD reduces the chance of an instrument degrading.
VICES have a cost and a benefit. e.g. HORNY increases HEAT but also TENSION. You'll need to have more relaxation time.
-> Recruit


