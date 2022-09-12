[< Previous 181](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-181/james-smith) |
[Next 183 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-183/james-smith)

# The Weekly Challenge 182

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-182/james-smith

# Task 1 - Sentence Order

***You are given a list of integers. Write a script to find the index of the first biggest number in the list.***

## Solution

```perl
sub max_index {
  my $m=0;
  $_[$_]>$_[$m] && ($m=$_) for 0..$#_;
  $m;
}
```

# Task 2 - Hot Day

***Given a list of absolute Linux file paths, determine the deepest path to the directory that contains all of them.***

## Solution

```perl
sub common_path {
  my $l = shift;
  $l = substr $l, 0, length( (($_^$l) =~ m{^(\0+)})[0]) for @_;
  substr $l, 0, rindex $l, '/';
}
```
