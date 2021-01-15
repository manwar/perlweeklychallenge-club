# Solution by Abigail

## [Task 1](https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/#TASK1): 

You are given a number `$N`.

Write a script to figure out if the given number is Palindrome.
Print `1` if true otherwise `0`.

### Examples
~~~~
Input: 1221
Output: 1

Input: -101
Output: 0, since -101 and 101- are not the same.

Input: 90
Output: 0
~~~~

### Solutions
* [awk](awk/ch-1.c)
* [C](c/ch-1.c)
* [Node](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)

### Blog
[Perl Weekly Challenge 95, Part 1](https://wp.me/pcxd30-kq)


## [Task 2](https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/#TASK2)

Write a script to demonstrate `Stack` operations like below:

* `push($n)` - add $n to the stack
* `pop()` - remove the top element
* `top()` - get the top element
* `min()` - return the minimum element

### Example
~~~~
my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       # removes 0
print $stack->top; # prints -1
$stack->push(0);
print $stack->min; # prints -1
~~~~

### Solutions
* [awk](awk/ch-2.awk)
* [C](c/ch-2.c)
* [Node](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Python](python/ch-2.py)

### Blog
[Perl Weekly Challenge 95, Part 2](https://wp.me/pcxd30-ld)
