
// X is always QUANTITY
// Y is always SIDES
// Z is always SUCCESS THRESHOLD / DC
// M is always MODIFIER

//-> testROLLER
=== testROLLER
Roll 1 dice with Y sides = {roll1dY(10)}
Roll X dice with Y sides = {roll1dY(10)}
Total Roll X dice with Y sides = {totalrollXdY(3,10)} 
Print Roll X dice with Y sides = {printrollXdY(3,10)} <br>
Tally Roll (print all rolls with a final tally) = {tallyrollXdY(3, 10)}
Total Roll (print only the final total) = {totalrollXdY(3,10)}

Roll 1 dice with Y sides and M modifier = {roll1dYwMod(10,5)}

Tally Roll X dice with Y sides and M modifier (print all rolls with a final total) = {tallyrollXdYwMod(3,10,5)}
Total Roll X dice with Y sides and M modifier (print only the final total) = {totalrollXdYwMod(3,10,5)}

Check if 1 of X dice with Y sides and M modifiers is equal to or greater than Z: 

{rollXdYwModsucceedonZ(3,10,10,5)}

{printSUCCESScountwMod(9,10,6,4)}

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

// <<<<<<<<<<<<<< DICE POOL ROLLER >>>>>>>>>>>>>>

=== function printrollXdY(x, y)
    { x > 0:
        ~ temp roll1 = roll1dY(y)
        {roll1} <>
        ~ printrollXdY(x-1,y)
    }


=== function rollXdYsucceedonZ(x,y,z)
    {z > y:
        ~ return "This roll is impossible."
    }
    
    ~ temp roll = "{printrollXdY(x,y)}"
    
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

=== function printrollXdYwMod(x, y,m)
    { x > 0:
        ~ temp roll1 = roll1dY(y) + m
        {roll1} <>
        ~ printrollXdYwMod(x-1,y,m)
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
    
    ~ temp roll = "{printrollXdYwMod(x,y,m)}"
    
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
    
=== function printSUCCESScountwMod(x,y,z,m)
You rolled {x} D{y} with a {m} modifier and got {countSUCCESSwMod(x,y,z,m)} successes against a DC of {z}.
    