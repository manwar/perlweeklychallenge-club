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

We proceed to do a pass of each array. 
```perl
sub min_index_sum {
  my( $b, %x, $t, $s, @best ) = ( 1e99, map { $_[0][$_] => $_ } reverse ( 0 .. $#{$_[0]} ) ); #1
  exists $x{$t = $_[1][$_]} && #3
    ( $b > ($s=$x{$t}+$_) ?  ($b,@best) = ( $s,$t ) #4
    : $b == $s            && push @best, $t )       #5
    for 0 .. $#{$_[1]}; #2
  return \@best;                                    #6
}
```

First we start with the first array and find the lowest index for each word in it - and store them in the hash `%x`. Note we work backwards through the list to ensure that it is the lowest index if the word is duplicated. This is the `map` in line 1.

We then loop through the second list of strings (`#2`) looking for words which are in the first list (`#3`). If it has a lower index sum that the best so far we record this and reset the list of words (`#4`). If it has the same we just push it onto the list. (`#5`)

At the end we just return the current list of words (which could be empty if there are no duplicates). (`#6`)

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

