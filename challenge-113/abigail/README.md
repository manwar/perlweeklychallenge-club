# Solutions by Abigail
## [Represent Integer](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK1)

> You are given a positive integer `$N` and a digit `$D`.
>
> Write a script to check if `$N` can be represented as a sum
> of positive integers having `$D` at least once. If check passes
> print `1` otherwise `0`.

### Example
~~~~
Input: $N = 25, $D = 7
Output: 0 as there are 2 numbers between 1 and 25 having the digit 7
        i.e. 7 and 17. If we add up both we don't get 25.

Input: $N = 24, $D = 7
Output: 1
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
[Perl Weekly Challenge 113: Represent
Integer](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html)

## [Recreate Binary Tree](https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2)

> You are given a Binary Tree.
> 
> Write a script to replace each node of the tree with the sum of
> all the remaining nodes

### Example
#### Input
~~~~
        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7
~~~~
#### Output
~~~~
        27
       /  \
      26  25
     /   /  \
    24  23  22
     \
     21
~~~~


### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)

### Blog
[Perl Weekly Challenge 113: Recreate Binary
Tree](https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-2.html)
