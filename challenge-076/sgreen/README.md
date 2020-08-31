# Perl Weekly Challenge 075

Solution by Simon Green.

## TASK #1 › Coins Sum

The great thing about both of this week's challenges is they require some thought about how to solve them before you type `use strict;` in your editor. Strap in, this is a pretty long README file.

For the coin toss task, it was obvious that some type of recursive subroutine was required. In this subroutine I pass three values:

1. The coins available (`$coins` arrayref)
2. The coins used so far to make the sum (`$sofar` arrayref)
3. The amount remaining (`$amount_remaining` number, the target minus the coins used so far)

Within the subroutine, I then went through the coins in order of value which resulted in one of three actions:

1. If the coin is less than the remaining amount, we need more coins. This is achieved by recursively calling the subroutine, adding the current coin the the `$sofar` arrayref and reducing the amount remaining by the coin value.
2. If the coin is the same as the remaining amount, we've found a combination (`$sofar` plus the current coin), and add that to the `@solutions` array.
3. If the coin is greater than the remaining amount, we can't use the coins. We can also exit the loop immediately as we know larger coins will also fail to produce a solution.

Some other notes:

- I check that every coin is a positive number. If we had '0' coins or negative coins, the list could be endless.
- The coins are ordered by value (low to high) and non-unique values are removed. The code would still work if we did have non-unique numbers, but that's just unnecessary.
- My original tests would return the same solution multiple times with the order reversed. For example, it would return '1, 1, 2' and '1, 2, 1'. To avoid this, I add a check in the recursive subroutine to skip coins less than the last used coin (if any).
- I could have put the amount and sorted unique list of coins as a global variable rather than using it in subroutine function, but global variable are just evil, mmkay? :P

### Examples

    » ./ch-1.pl 1 2 4 6
    1, 1, 1, 1, 1, 1
    1, 1, 1, 1, 2
    1, 1, 2, 2
    1, 1, 4
    2, 2, 2
    2, 4

## TASK 2 › Largest Rectangle Histogram

This tasks also involved a bit of thinking before hitting the keyboard. For the first part of the task (calculating the largest rectangle), I used the following methodology:

- The largest rectangle will always start at the first column.
- Using this, I worked through the rows from left to right ( `0` to `@#array`).
- We now know the start of the rectangle, so we can calculate all the rectangles from this point. To do this, we go through the remaining rows on the right, starting with the current row. We find the minimum value in the array for the selected rows. The size of the rectangle is ($last_row - $first_row + 1 ) × the minimum height.
- As a bonus, I also record the rows and columns that make up the rectangle, and display this in the result. It handles situations where there is more than one combination that makes up the rectangle.

### Bonus round

Who doesn't like bonus points? :)

The major issue in tackling this part of the task is handling the width of each part of the output. Each column needs to be the length of the highest amount as the first column and last row needs to show the height of each row.

I make extensive use of the [`x` operator](https://perldoc.pl/perlop#Multiplicative), which repeats a scalar or list a specified number of times, and the map and sprintf functions.

The output is broken into three parts.

1. Print the body of the graph. Count from the maximum value to 1, print the number, and then for each row print a '#' character if the value of the row is <= the current count.
2. Print the row of dashes. This uses the x operator twice.
3. Finally print the totals as the last row.

Still here? Thanks for reading :)

## Examples

    » ./ch-2.pl 2 1 4 5 3 7
    Largest rectangle histogram is 12 (rows 3 - 6 cols 1 - 3)

    7           #
    6           #
    5       #   #
    4     # #   #
    3     # # # #
    2 #   # # # #
    1 # # # # # #
    - - - - - - -
      2 1 4 5 3 7

    » ./ch-2.pl 3 2 3 5 7 5
    Largest rectangle histogram is 15 (rows 4 - 6 cols 1 - 5)
    
    7         #  
    6         #  
    5       # # #
    4       # # #
    3 #   # # # #
    2 # # # # # #
    1 # # # # # #
    - - - - - - -
      3 2 3 5 7 5
