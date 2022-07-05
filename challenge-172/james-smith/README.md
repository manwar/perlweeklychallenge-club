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

If `$n` is one - then a partition exists iff `$m` is prime (We use `is_prime` from  `Math::Prime::Util` to check this.

Our first digit is going to be from `2` to the largest prime below `($m-($n-1)/2)/$n`. Again `Math::Prime::Util` has a method `primes` for this. We tnen recurse with the `partition` function but this time we replace `$m` with `$m-$p`, `$n` with `$n-1` and `2` with the next prime after `$p`.

This gives us:

```perl
sub partition {
  my ( $m, $n, $p ) = (@_,0);
  $n > 1
  ? map { $p = $_;
          map { [ $p, @{$_} ] }
              partition( $m-$p, $n-1, $p )
        } @{ primes $p+1, int( ($m-$n/2+1/2)/$n ) }
  : $m > $p && is_prime $m ? [$m] : ();
}
```

Note we add a `0` to `@_` so that if (in the first call) `@_` only has two numbers `$p` is set to zero.

# Task 2 - Five number summary

***You are given an array of integers.  Write a script to compute the five-number summary of the given set of integers. (min,lower-quartile,median,upper-quarile,max)***

## Solution

We will present three code solutions as the quartiles and median are not-uniquely defined in some cases.

```perl
sub fivenum_avg {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $sort[$_->[0]] * (1 - $_->[1]) + ( $_->[1] ? $_->[1] * $sort[$_->[0]+1] : 0 ) }
    map { [ int $_, $_ - int $_ ] }
    map { $_/4*(@_-1) } 0..4
  ];
}

sub fivenum_mid {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $_->[1] ? ($sort[$_->[0]] + $sort[$_->[0]+1])/2 : $sort[$_->[0]] }
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }
    map { $_/4*(@_-1) } 0..4
  ];
}

sub fivenum_range {
  my @sort = sort { $a <=> $b } @_;
  [
    map { $_->[1] ? '<'.$sort[$_->[0]].'-'.$sort[$_->[0]+1].'>' : $sort[$_->[0]] }
    map { [ int $_, ($_ == int $_) ? 0 : 1 ] }
    map { $_/4*(@_-1) } 0..4
  ];
}
```
