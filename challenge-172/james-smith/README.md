[< Previous 171](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-171/james-smith) |
[Next 173 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-173/james-smith)

# The Weekly Challenge 172

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-172/james-smith

# Task 1 - Prime partition

***You are given two positive integers, `$m` and `$n`.  Write a script to find out the Prime Partition of the given number. No duplicates allowed.***

## Solution

The first thing to note that this is perfect case for a recursive solution.

If `$n` is one - then a partition exists iff `$m` is prime (We use `is_prime` from  `Math::Prime::Util` to check this. In this case we return `[$m]` or `()` respectively.

If not our first digit is going to be from `2` to the largest prime below `($m-($n-1)/2)/$n`. Again `Math::Prime::Util` has a method `primes` method for this. We then recurse with the `partition` function but this time we replace `$m` with `$m-$p`, `$n` with `$n-1` and `2` with the next prime after `$p`.

This gives us:

```perl
sub partition {
  my ( $m, $n, $p ) = ( @_, 0 );
    $n > 1
  ? map { $p = $_;
          map { [ $p, @{$_} ] } partition( $m-$p, $n-1, $p )
        } @{ primes $p+1, int( ( $m - $n/2 + 1/2 ) / $n ) }
  : $m > $p && is_prime $m ? [ $m ] : ();
}
```

**Note** we add a `0` to `@_` so that if (in the first call) `@_` only has two numbers `$p` is set to zero.

### Only one partition

If you only wish to get **a** partition then we simply tweak the code to have a return in the inner map - to return the entry if we find it!

```perl
sub first_partition {
  my ( $m, $n, $p ) = ( @_, 0 );
    $n > 1
  ? map { $p = $_;
          map { return [ $p, @{$_} ] } first_partition( $m-$p, $n-1, $p )
        } @{ primes $p+1, int( ( $m - $n/2 + 1/2 ) / $n ) }
  : $m > $p && is_prime $m ? [ $m ] : ();
}
```

# Task 2 - Five number summary

***You are given an array of integers.  Write a script to compute the five-number summary of the given set of integers. (min,lower-quartile,median,upper-quarile,max)***

## Solution

We will present three code solutions as the quartiles and median are not-uniquely defined in some cases.

 * `fivenum_range` - if the median/quartile falls between two entries {and the entries are different} - we return the two values as a "range"
 * `fivenum_med` -  if the median/quartile falls between two entries - then the average of the two values is used
 * `fivenum_avg` - if the median/quartile falls between two entries - then a weighted average is used. With more weight given to the point nearest the fraction { for median this will be the mid-point } but for the quartiles the weighting could be 1/4 : 3/4.

```perl
sub fivenum_avg {
  my @sort = sort { $a <=> $b } @_;                 # sort values
  [
    map { $_->[1]                                   # If lies between 2 points
        ? ( 1 - $_->[1] ) * $sort[ $_->[0]     ] +  # compute weighted average
                $_->[1]   * $sort[ $_->[0] + 1 ]
        : $sort[ $_->[0] ]                          # o/w return value
        }
    map { [ int $_, $_ - int $_ ] }                 # get LH-index, and distance of point from this
    map { $_/4*(@_-1) } 0..4                        # calculate index
  ];
}

sub fivenum_mid {
  my @sort = sort { $a <=> $b } @_;                 # sort values
  [
    map { $_->[1]                                   # If lies between 2 points
        ? ($sort[$_->[0]] + $sort[$_->[0]+1])/2     # compute average
        : $sort[$_->[0]]                            # o/w return value
        }                                      
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }      # get LH-index {and flag if point lies between 2 numbers
    map { $_/4*(@_-1) } 0..4                        # calculate index
  ];
}

sub fivenum_range {
  my @sort = sort { $a <=> $b } @_;                      # sort values
  [
    map { $_->[1] && $sort[$_->[0]] != $sort[$_->[0]+1]  # If lies between 2 points
      ? '<'.$sort[$_->[0]].'-'.$sort[$_->[0]+1].'>'      # return "range"
      : $sort[$_->[0]]                                   # o/w return value
      }
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }           # get LH-index {and flag if point lies between 2 numbers
    map { $_/4*(@_-1) } 0..4                             # calculate index
  ];
}
```
