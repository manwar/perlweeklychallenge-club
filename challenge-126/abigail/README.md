# Solutions by Abigail
## [Count Numbers][task1]

> You are given a positive integer `$N`.
> 
> Write a script to print count of numbers from `1` to `$N` that don't
> contain digit `1`.

### Example

~~~~
Input: $N = 15
Output: 8
~~~~

There are 8 numbers between `1` and `15` that don't contain digit `1`:
`2, 3, 4, 5, 6, 7, 8, 9`.

~~~~
Input: $N = 25
Output: 13
~~~~

There are 13 numbers between `1` and `25` that don't contain digit `1`:
`2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25`.


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
[Perl Weekly Challenge 126: Count Numbers][blog1]

## [Minesweeper Game][task2]

> You are given a rectangle with points marked with either `x` or `*`.
> Please consider the `x` as a land mine.
> 
> Write a script to print a rectangle with numbers and `x` as in the
> Minesweeper game.
> 
> > A number in a square of the minesweeper game indicates the
> > number of mines within the neighbouring squares (usually `8`),
> > also implies that there are no bombs on that square.

### Example

~~~~
Input:
    x * * * x * x x x x
    * * * * * * * * * x
    * * * * x * x * x *
    * * * x x * * * * *
    x * * * x * * * * x

Output:
    x 1 0 1 x 2 x x x x
    1 1 0 2 2 4 3 5 5 x
    0 0 1 3 x 3 x 2 x 2
    1 1 1 x x 4 1 2 2 2
    x 1 1 3 x 2 0 0 1 x
~~~

### Solutions
* [AWK](awk/ch-2.awk)
* [Perl](perl/ch-2.pl)

### Blog
[Perl Weekly Challenge 126: Minesweeper Game][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/#TASK1
[task2]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-126-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-126-2.html
