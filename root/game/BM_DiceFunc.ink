
// X is always QUANTITY
// Y is always SIDES
// Z is always SUCCESS THRESHOLD / DC
// M is always MODIFIER

// TOTAL is a single INT value
// SHOW_ROLLS is a STRING with the value of the individual rolls shown
// TALLY is a STRING with ROLLS and TOTAL
// PRINT is to put the ROLL/TALLY/TOTAL into a sentence.


-> testROLLER
=== testROLLER
[img]IAGES/totoro.gif[/img]

{showrollXd6(3)}
and
{rollXd6succeedonZ(6 ,6)}

{rollXd6succeedonZ(2,6)}

Total Roll 1 dice with Y sides = {roll1dY(10)}
Total Roll X dice with Y sides = {totalrollXdY(3,10)}
Show Roll X dice with Y sides = {showrollXdY(3,10)} <br>
Tally Roll X dice with Y sides (show all rolls with a final total as string) = {tallyrollXdY(3, 10)}


Total Roll 1 dice with Y sides and M modifier = {roll1dYwMod(10,5)}

Tally Roll X dice with Y sides and M modifier = {tallyrollXdYwMod(3,10,5)}
Total Roll X dice with Y sides and M modifier = {totalrollXdYwMod(3,10,5)}

Show Roll & Check if at least 1 of X dice with Y sides and M modifiers is equal to or greater than Z: 
... <>{rollXdYwModsucceedonZ(3,10,10,5)}

Check & Print how many of X dice with Y sides and M modifiers is equal to or greater than Z: 
... <>{showSUCCESScountwMod(9,10,6,4)}

->DONE

// <<<<<<<<<<<<<< UNIVERSAL DICE FUNCTIONS >>>>>>>>>>>>>>

=== function roll1dY(y)
    ~ return RANDOM(1, y)

=== function rollSUCCEEDorFAIL(y, z,roll)
    { 
    - "{roll}" ? "{z}":
            <>succeed.
    - "{succeedonZ(y,z,roll)}" ? "SUCCESS":
            <>succeed.
    - else:
            <>failed.
    }
          
=== function succeedonZ(y,z,var)  
    { 
    - "{var}" ? "{z}":
        <>SUCCESS
    - y - z == 0:
        ~ return    
    -else:
     ~ succeedonZ(y,z+1,var)   
    }  

// <<<<<<<<<<<<<< D6 POOL IMAGE ROLLER >>>>>>>>>>>>>>

=== function showrollXd6(x)
    { x > 0:
        ~ temp roll1 = roll1dY(6)
        ~ printD6image( roll1 )
        ~ showrollXd6(x-1)
    -else:
        
        ~return
    }

=== function printD6image(x)
{ x:
- 1:     [img]IMAGES/D6_ONE.png[/img] <>
- 2:     [img]IMAGES/D6_TWO.png[/img] <>
- 3:     [img]IMAGES/D6_THREE.png[/img] <>
- 4:     [img]IMAGES/D6_FOUR.png[/img] <>
- 5:     [img]IMAGES/D6_FIVE.png[/img] <>
- 6:     [img]IMAGES/D6_SIX.png[/img] <>
- else:  not a d6.
}

=== function rollXd6succeedonZ(x ,z)
    {z > 6:
        ~ return "This roll is impossible."
    }
    
    ~ temp roll = "{showrollXd6(x)}"
    
    You rolled<br> {roll}<br> which means you {rollSUCCEEDorFAIL(6, z,roll)}


// <<<<<<<<<<<<<< DICE POOL ROLLER >>>>>>>>>>>>>>

=== function showrollXdY(x, y)
    { x > 0:
        ~ temp roll1 = roll1dY(y)
        {roll1} <>
        ~ showrollXdY(x-1,y)
    }


=== function rollXdYsucceedonZ(x,y,z)
    {z > y:
        ~ return "This roll is impossible."
    }
    
    ~ temp roll = "{showrollXdY(x,y)}"
    
    You rolled {roll} which means you {rollSUCCEEDorFAIL(y, z,roll)}

     
  
 // <<<<<<<<<<<<<< DICE TALLY and TOTAL ROLLER >>>>>>>>>>>>>>
 
 
=== function tallyrollXdY(x, y)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = roll1dY(y)
    ~ temp roll2 = tallyrollXdY(x-1,y)
    <> {roll1} <U+0020> //unicode whitespace character
    ~ return roll1 + roll2

=== function totalrollXdY(x, y)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = roll1dY(y)
    ~ temp roll2 = totalrollXdY(x-1,y)
    ~ return roll1 + roll2
 
// <<<<<<<<<<<<<< DICE w MOD ROLLER >>>>>>>>>>>>>>

=== function roll1dYwMod(y,m)
    ~ temp roll = roll1dY(y) + m
    ~ return roll

=== function showrollXdYwMod(x, y,m)
    { x > 0:
        ~ temp roll1 = roll1dY(y) + m
        {roll1} <>
        ~ showrollXdYwMod(x-1,y,m)
    }

=== function totalrollXdYwMod(x, y,m)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = roll1dY(y) + m
    ~ temp roll2 = totalrollXdYwMod(x-1, y, m)
    ~ return roll1 + roll2

=== function tallyrollXdYwMod(x, y, m)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = roll1dY(y) + m
    ~ temp roll2 = tallyrollXdYwMod(x-1, y, m)
    <> {roll1} <U+0020> //unicode whitespace character
    ~ return roll1 + roll2  

=== function rollXdYwModsucceedonZ(x,y,z,m)
    {z > y + m:
        ~ return "This roll is impossible."
    }
    
    ~ temp roll = "{showrollXdYwMod(x,y,m)}"
    
    You rolled {roll} which means you {rollSUCCEEDorFAIL(y, z - m,roll)}

=== function countSUCCESS_rollXdYonZ(x, y, z)
    ~ temp successCount = 0
    {x == 0: 
        ~ return 0
    }
    ~ temp roll1 = roll1dY(y)
    
    //{successCount + countSUCCESS_rollXdYonZ(x-1, y, z)}
      
=== function countSUCCESS_roll1dYonZ(y, z)
    ~ temp roll1 = roll1dY(y)
    {roll1 >= z:
        ~ return 1
    }
        ~ return 0

=== function countSUCCESS(x,y,z)
    {x == 0: 
        ~ return 0
    }
    ~ temp count1 = countSUCCESS_roll1dYonZ(y, z)
    ~ temp count2 = countSUCCESS(x-1,y,z)
    ~ return count1 + count2
    
=== function countSUCCESSwMod(x,y,z,m)
    ~ return countSUCCESS(x,y,z-m)    
    
=== function showSUCCESScountwMod(x,y,z,m)
You rolled {x} D{y} with a {m} modifier and got {countSUCCESSwMod(x,y,z,m)} successes against a DC of {z}.
    