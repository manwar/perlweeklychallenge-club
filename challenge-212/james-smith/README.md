[< Previous 210](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-210/james-smith) |
[Next 212 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-212/james-smith)

# The Weekly Challenge 211

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-211/james-smith

# Task 1: Toeplitz Matrix

***You are given a matrix `m` x `n`. Write a script to find out if the given matrix is Toeplitz Matrix. A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.***

## Solution


```perl
sub toeplitz {
  return if @_ > @{$_[0]};                   ## unclear but no diagonals...
  my @st = @{$_[0]}[ 0 .. @{$_[0]} - @_ ];
  for my $r ( 1 .. $#_ ) {
    $st[$_] == $_[$r][$r+$_] || return 0 for 0 .. $#st;
  }
  1
}
```

Firstly we check to see if we have more rows than columns (there are no full diagonals) so there is no result.

Then we grab the first row of each of the diagonal - the number of possible diagonals is `columns - rows + 1`.
We then loop through each other row - and find the chunk of the row on the diagonal - and compare it with the first row.

If there is a difference we return `0`;

If the are no differences we return `1`;

# Task 2: Number Collision

***You are given an array of integers. Write a script to find out if the given can be split into two separate arrays whose average are the same..***

## Solution

First we compute the overall average of the sets of numbers (or at least the sum and the count). We then loop through all subsets of numbers to see if we can find a subset with the same average.

We can enumerate sub sets by using a binary mask to choose elements - For every solution there are two sets one whic includes the first number and one that doesn't - as we only need to calculate one set - then we can always assume that the first entry is NOT in the set we are summing.

To compare the means we could use `TOTAL_all / COUNT_all == TOTAL_subset / COUNT_subset` but this involves division which isn't good - but we can rewrite this as:
`TOTAL_all * COUNT_subset == TOTAL_subset * COUNT_all`.

We enumerate the sets from `1` to `2^(n-1) - 1` the bits representing whether or not the number is in one set or the other.

```perl
sub equal_split {
  my( $t, $c ) = ( 0, scalar @_ );
  $t += $_ for @_;
  for my $x ( 1 .. ( 1 << $c-1 ) -1 ) {
    my( $m, $n ) = ( 0, 0 );
    ( $x & 1 ) && ( $m += $_[$_], $n++ ), $x >>= 1 for 1 .. $c-1;
    return 1 unless $n*$t-$m*$c;
  }
  0
}
```
