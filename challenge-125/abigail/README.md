# Solutions by Abigail
## [Pythagorean Triples][task1]

> You are given a positive integer `$N`.
>
> Write a script to print all Pythagorean Triples containing $N as
> a member. Print `-1` if it can't be a member of any.
>
> Triples with the same set of elements are considered the same,
> i.e. if your script has already printed `(3, 4, 5)`, `(4, 3, 5)` should
> not be printed.
>
> > The famous Pythagorean theorem states that in a right angle
> > triangle, the length of the two shorter sides and the length of the
> > longest side are related by `a^2+b^2 = c^2`.

### Example
~~~~
Input: $N = 5
Output: (3, 4, 5)
        (5, 12, 13)

Input: $N = 13
Output: (5, 12, 13)
        (13, 84, 85)

Input: $N = 1
Output: -1
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [C](c/ch-1.c)
* [Go](go/ch-1.go)
* [Java](java/ch-1.java)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Pascal](pascal/ch-1.p)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [R](r/ch-1.r)
* [Ruby](ruby/ch-1.rb)
* [Tcl](tcl/ch-1.tcl)

### Blog
[Perl Weekly Challenge 125: Pythagorean Triples][blog1]

## [Binary Tree Diameter][task2]

> You are given binary tree as below:

~~~~
    1
   / \
  2   5
 / \ / \
3  4 6  7
       / \
      8  10
     /
    9
~~~~

> Write a script to find the diameter of the given binary tree.
>
> > The diameter of a binary tree is the length of the longest path
> > between any two nodes in a tree. It doesn't have to pass
> > through the root.

For the above given binary tree, possible diameters (7) are:

~~~~
3, 2, 1, 5, 7, 8, 9
~~~~

or

~~~~
4, 2, 1, 5, 7, 8, 9
~~~~

### Solutions
* [Perl](perl/ch-2.pl)

### Blog
[Perl Weekly Challenge 125: Binary Tree Diameter][blog2]



[task1]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-125/#TASK1
[task2]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-125/#TASK2
[blog1]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-125-1.html
[blog2]: https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-125-2.html
