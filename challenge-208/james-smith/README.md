[< Previous 207](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-207/james-smith) |
[Next 209 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-209/james-smith)

# The Weekly Challenge 208

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-208/james-smith

# Task 1: Minimum Index Sum

***You are given two arrays of strings. Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.***

## Solution

I'm going to profer two solutions. The second is "nicer" from a design point BUT the extra overhead is probably too much.

# Task 2: Duplicate and Missing

Try all combinations and 
***You are given an array of integers in sequence with one missing and one duplicate. Write a script to find the duplicate and missing integer in the given array. Return `-1` if none found. For the sake of this task, let us assume the array contains no more than one duplicate and missing.***

## Observation

It is not 100% clear in the desciption - but we have assumed that it means a list of integers from `n` ... `m` with a step of `1`.

## Solution

We loop through looking for a duplicate `$p[n+1]==$p[$n]` or gap `$p[n+1]!=$p[$n]+1`.

We have two special cases - if there are no duplicates return -1 

```perl
sub dup_missing {
  my($p,$d,$m) = shift;
  ($_==$p ? ($d=$_) : $_ == $p+2 && ($m=$_-1)), $p=$_ for @_;
  defined $d ? ( defined $m ? [ $d, $m ] : [ $d,$p+1  ] ): [-1]
}

```
We note that if the two neighbouring values are the same we have found the duplicate, and if the difference is `2` we've found the missing value.

At the end of the loop we have 3 cases:

 1) We have not found the duplicate (`$d` is undefined) - so we return `[-1]`;
 2) We have found the duplicate and we've found the missing value as well so we return `[$d,$m]`;
 3) We have found the duplicate BUT we haven't found the missing value - there is no solution here - the missing value is at one end or other of the list. As at this point we know what the last value of the list is (but not the first - we threw that away) we just return last value + 1.

