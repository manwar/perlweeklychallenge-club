# Perl Weekly Challenge #126

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-126/james-smith/perl

# Task 1 - Count Numbers

***You are given a positive integer `$N` - Write a script to print count of numbers from `1` to `$N` that don’t contain digit `1`.***

## The solution

First pass - just do the simple `O(n)` thing which is to loop through all `$N` numbers and count those without `1`s.

```perl
sub get_no_one_count {
  my $n = shift;
  return scalar grep { ! m{1} } 2..$n;
}
```

If we look at a few numbers we see that for powers of 10 we see we have values 8, 80, 728, 6560, 59048, ... what we notices these are all of the form `9^$N-1`.... For multiples of these we see that for the total is `(n-1)*9^N`.

We see we can then add these up - with one exception if we find a 1 we stop the loop (or if working backwards) throw any calculations away - giving us the order `O(ln n)` solution:

```perl
sub get_no_one_count_9 {
  my ( $n, $count, $pow_9 ) = ( shift, 0, 1 );
  while($n) {
    my $t   = $n % 10; ## get last digit
    $count  = 0 if $t==1; ## Throw everything away we've found a 1
    $count += $t ? ( $t == 1 ? ($pow_9-1) : ($t-1)*$pow_9 ) : 0;
                          ## 0 it contributes nothing
                          ## 1 contributes 9^X-1
                          ## 2-9 contributes (n-1)9^X
    $pow_9 *= 9;  ## update power of nine
    $n      = ( $n - $t )/10; ## drop last digit
  }
  return $count;
}
```

## Comparison
Even for 2 digit numbers this speed up is good (72x), but as N increases
we see that gain gets higher and higher.. for 7 digit numbers the speed
up is 6 orders of magnitude.

| N         | scan      | opt       | Speed-up   |
| --------: | --------: | --------: | ---------: |
|        98 | 16,027    | 1,173,850 |        72  |
|       987 |  2,623    |   867,796 |       330  |
|     9,876 |    253    |   685,956 |     2,715  |
|    98,765 |     24.4  |   565,427 |    23,155  |
|   987,654 |      1.23 |   482,800 |   392,998  |
| 9,876,543 |      0.23 |   418,410 | 1,853,771  |

# Task 2 - Minesweeper Game

***You are given a rectangle with points marked with either `x` or `*`. Consider the `x` as a land mine. Write a script to print a rectangle with numbers and `x` as in the Minesweeper game.***

## Solution

```perl
sub solve {
  my @res = ();
  my @g = map { [ map { $_ eq 'x' ? 1 : 0 } split //, $_ ] } @_;

  my( $h, $w ) = ( $#_, -1 + length $_[0] );
  foreach my $y ( 0 .. $h ) {
    push @res, join '', map {
      $g[$y][$_] ? 'x' :
        ( $y    ? ( $_ ? $g[$y-1][$_-1] : 0 ) + $g[$y-1][$_] + ( $_<$w ? $g[$y-1][$_+1] : 0 ) : 0 ) +
                  ( $_ ? $g[$y  ][$_-1] : 0 ) + $g[$y  ][$_] + ( $_<$w ? $g[$y  ][$_+1] : 0 )       +
        ( $y<$h ? ( $_ ? $g[$y+1][$_-1] : 0 ) + $g[$y+1][$_] + ( $_<$w ? $g[$y+1][$_+1] : 0 ) : 0 )
     } 0 .. $w;
  }
  return join "\n", @res;
}
```

There are two stages to this:

 1. convert the strings into an array of `1`s and `0`s representing mines and spaces.
 2. we compute the convulation - counting the number of mines in adjacent squares (or tagging with a "x" if the square is bomb).
   Rather than using loops and if statements we use nested ternary operators in a single line

