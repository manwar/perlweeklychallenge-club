# Missing Reversed Inversions
## Task 1: Missing Members
> You are given two arrays of integers.
> Write a script to find out the missing members in each other arrays.

In set theory, given two sets A and B, this task asks for the difference sets A \ B and B \ A.

There are many approches to solve this with Perl.
The most basic way would be to use hashes as representations of sets.
Hash slices come *very* handy when an array shall be convertet to as set:
```
my @a = (...);
my %ha;
@ha{@a} = ();
```
Now `%h` is a hash with all members of `@a` as keys.
Taking the set difference A \ B to a second array `@b` is as easy as:
```
@b = (...);
delete @ha{@b};
```
However, I prefer a more functional approach.
Using PDL ndarrays of unique sorted numbers as set representations.
Then we may use PDL set operation in a natural way to solve the task:
```
$m1 = long(...)->uniq;
```
makes `$m1` a 1-d ndarray representing a set and
```
setdiff_sorted($m1, $m2);
```
gives M1 \ M2.
Same result, but better readable.
## Task 2: Flip Matrix
> You are given `n x n` binary matrix. 
> Write a script to flip the given matrix as below.
 
Again, with PDL this task is almost trivial.
Using `PDL::NiceSlice` we may reverse a dimension using the notation `(-1:0)`.
Reverting a value is done with the unary negation operator `!`.
Performing the "flip matrix" operation on a 2-d ndarray `$m` thus is as easy as:
```
!$m->(-1:0)
```