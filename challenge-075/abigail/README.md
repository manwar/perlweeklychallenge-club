# Solutions by Abigail

## [Coins Sum](https://theweeklychallenge.org/blog/perl-weekly-challenge-075/#task-1--coins-sum)

> You are given a set of coins `@C`, assuming you have infinite amount
> of each coin in the set.
> 
> Write a script to find how many ways you make sum `$S` using the coins
> from the set `@C`.

### Example
~~~~
Input:
    @C = (1, 2, 4)
    $S = 6

Output: 6
There are 6 possible ways to make sum 6.
a) (1, 1, 1, 1, 1, 1)
b) (1, 1, 1, 1, 2)
c) (1, 1, 2, 2)
d) (1, 1, 4)
e) (2, 2, 2)
f) (2, 4)
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)


## [Largest Rectangle Histogram](https://theweeklychallenge.org/blog/perl-weekly-challenge-075/#task-2--largest-rectangle-histogram)

> You are given an array of positive numbers @A.
> 
> Write a script to find the largest rectangle histogram created by
> the given array.<br>
> *BONUS: Try to print the histogram as shown in the example, if possible.*

### Examples
#### Example 1
~~~~
Input: @A = (2, 1, 4, 5, 3, 7)

     7           #
     6           #
     5       #   #
     4     # #   #
     3     # # # #
     2 #   # # # #
     1 # # # # # #
     _ _ _ _ _ _ _
       2 1 4 5 3 7
~~~~
Looking at the above histogram, the largest rectangle `(4 x 3)`
is formed by columns `(4, 5, 3 and 7)`.

#### Example 2
~~~~
Input: @A = (3, 2, 3, 5, 7, 5)

     7         #
     6         #
     5       # # #
     4       # # #
     3 #   # # # #
     2 # # # # # #
     1 # # # # # #
     _ _ _ _ _ _ _
       3 2 3 5 7 5
~~~~
Looking at the above histogram, the largest rectangle `(3 x 5)`
is formed by columns `(5, 7 and 5)`.

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-1.rb)
