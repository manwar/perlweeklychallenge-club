[< Previous 205](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-205/james-smith) |
[Next 207 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-207/james-smith)

# The Weekly Challenge 206

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-2065/james-smith

# Task 1: Shortest Time

***You are given a list of time points, at least 2, in the 24-hour clock format `HH:MM`. Write a script to find out the shortest time in minutes between any two time points.***

## Solution

We will do a pairwise comparison of each pair. The shortest time for any pair is either going from the absolute differences in times directly - OR going through midnight. These are `abs( t1 - t2 )` or `abs( t1 + t2 - 1440 )`. The code becomes:

```perl
sub shortest_time {
  my $min = 1_440, @_ = map { @Q = split /:/; $Q[0]*60 + $Q[1] } @_;
  while( defined (my $t = shift) ) {
    abs( $t-$_       ) < $min && ( $min = abs $t-$_       ),
    abs( $t+$_-1_440 ) < $min && ( $min = abs $t+$_-1_440 ) for @_;
  }
  $min
}
```

Now how efficient is this - though - is there a better way to use built-in perk functions?

If we sort the times in order, we only have to compare the `n` gaps, from the last to the first through midnight and each of the subsequent neighbours.

This gives us two alternative code blocks:

```perl
sub shortest_time {
  @_ = map { my @Q = split /:/; $Q[0]*60 + $Q[1] } sort @_;
  my $min = 1440 + (my $t = shift) - $_[-1];
  ($_-$t<$min) && ($min=$_-$t), $t=$_ for @_;
  $min
}
```

or:

```perl
sub shortest_time {
  @_ = sort { $a<=>$b } map { my @Q = split /:/; $Q[0]*60 + $Q[1] } @_;
  my $min = 1440 + (my $t = shift) - $_[-1];
  ($_-$t<$min) && ($min=$_-$t), $t=$_ for @_;
  $min
}
```

Which of these is fastest? The `sort` method is much more efficient than the pairwise approach (It's `O(n.log n)` where the pairwise solution is `O(n^2)`. Of the two the second numeric `sort` after the `map` if slightly faster than the `map` after the string `sort`.

# Task 2: Array Pairings

***You are given an array of integers having even number of elements. Write a script to find the maximum sum of the minimum of each pairs.***

## Solution

There is a trick here - the optimal solution is achieved by sorting the array into order and then chunking into to pairs... Then take the minimum of each...

```perl
sub max_sum_pair_min {
  my $t = 0, @_ = sort {$a<=>$b} @_;
  $t += shift, shift while @_;
  $t
}
```

When we `shift`, `shift` the first value is added to the total, the second value is discarded.
