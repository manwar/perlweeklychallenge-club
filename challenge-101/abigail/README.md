# Solution by Abigail
## [Pack a Spiral](https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/#TASK1)

You are given an array `@A` of items (integers say, but they can be anything).

Your task is to pack that array into an `MxN` matrix spirally
counterclockwise, as tightly as possible.

'Tightly' means the absolute value `|M-N|` of the difference has to be as
small as possible

### Examples
#### Example 1
~~~~
Input: @A = (1,2,3,4)

Output:

    4 3
    1 2
~~~~

Since the given array is already a `1x4` matrix on its own, but that's
not as tight as possible. Instead, you'd spiral it counterclockwise into

~~~~
    4 3
    1 2
~~~~
#### Example 2
~~~~
Input: @A = (1..6)

Output:

    6 5 4
    1 2 3
~~~~
or
~~~~
    5 4
    6 3
    1 2
~~~~
Either will do as an answer, because they're equally tight.

#### Example 3
~~~~
Input: @A = (1..12)

Output:
       9  8  7 6
      10 11 12 5
       1  2  3 4
~~~~
or
~~~~
       8  7 6
       9 12 5
      10 11 4
       1  2 3
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

### Blog
[Perl Weekly Challenge 101: Pack a Spiral](https://wp.me/pcxd30-r7)


## [Origin-containing Triangle](https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/#TASK2)

You are given three points in the plane, as a list of six co-ordinates:
`A=(x1,y1)`, `B=(x2,y2)` and `C=(x3,y3)`.

Write a script to find out if the triangle formed by the given three
co-ordinates contain origin `(0,0)`.

Print `1` if found otherwise `0`.

### Examples
#### Example 1
~~~~
Input: A=(0,1), B=(1,0) and C=(2,2)

Output: 0 because that triangle does not contain (0,0).
~~~~

#### Example 2
~~~~
Input: A=(1,1), B=(-1,1) and C=(0,-3)

Output: 1 because that triangle contains (0,0) in its interior.
~~~~

#### Example 3
~~~~
Input: A=(0,1), B=(2,0) and C=(-6,0)

Output: 1 because (0,0) is on the edge connecting B and C.
~~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [Befunge-93](befunge-93/ch-2.bf93)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Perl Weekly Challenge 101: Origin-containing Triangle](https://wp.me/pcxd30-s8)
