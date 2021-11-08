# Solutions by Abigail
## [Maximum Sub-Matrix][task1]

> You are given m x n binary matrix having 0 or 1.
> 
> Write a script to find out maximum sub-matrix having only 0


### Examples

~~~~
Input : [ 1 0 0 0 1 0 ]
        [ 1 1 0 0 0 1 ]
        [ 1 0 0 0 0 0 ]

Output: [ 0 0 0 ]
        [ 0 0 0 ]
~~~~

~~~~
Input : [ 0 0 1 1 ]
        [ 0 0 0 1 ]
        [ 0 0 1 0 ]

Output: [ 0 0 ]
        [ 0 0 ]
        [ 0 0 ]
~~~~


### Solutions
* [Perl](perl/ch-1.pl)

### Blog
[Perl Weekly Challenge 128: Maximum Sub-Matrix][blog1]

## [Minimum Platforms][task2]

> You are given two arrays of arrival and departure times of trains
> at a railway station.
> 
> Write a script to find out the minimum number of platforms needed
> so that no train needs to wait.

### Examples

~~~~
Input: @arrivals   = (11:20, 14:30)
       @departutes = (11:50, 15:00)
Output: 1
~~~~

The 1st arrival of train is at 11:20 and this is the only train at
the station, so you need 1 platform.  Before the second arrival at
14:30, the first train left the station at 11:50, so you still need
only 1 platform.

~~~~
Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
       @departutes = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)
Output: 3
~~~~

Between 11:00 and 12:20, there would be at least 3 trains at the
station, so we need minimum 3 platforms.

### Solutions
* [AWK](awk/ch-2.awk)
* [C](awk/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)

### Blog
[Perl Weekly Challenge 128: Minimum Platforms][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-128/#TASK1
[task2]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-128/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-128-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-128-2.html
