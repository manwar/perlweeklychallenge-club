# Perl Weekly Challenge #120

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-121/james-smith/perl

# Task 1 - Invert Bit

***You are given integers `0 <= $m <= 255` and `1 <= $n <= 8`. Write a script to invert `$n` bit from the end of the binary representation of `$m` and print the decimal representation of the new binary number.***

## The solution

To invert a particular bit we can **xor**(`^`) `2^($n-1)` with the number in question. We can simplify the `2^($n-1)` by rewriting as `1<<$n-1` this is using bit-shift operators. So the function simply becomes.

```perl
sub flip_bit {
  return $_[0] ^ 1<<$_[1]-1;
}
```

# Task 2 - The Travelling Salesman

***You are given a `NxN` matrix containing the distances between `N` cities. Write a script to find a round trip of minimum length visiting all `N` cities exactly once and returning to the start.***

## Solution.

This is very similar to the pre-computed distance "Adventure of Knight" solution from challenge 118, the only change we have to do is add the distance from the last node to the start node. The only change is when the list of "targets" left is of length 1. In that problem we were not expected to return to the start...

The addition is this condition:
```perl
  if(@r=1) { 
    $len = $dist_maps->[$start][$r[0]] + $dist_maps->[$r[0]][0];
    $rt = chr(65+$r[0]).'A';
  } else {
```

Giving us our walking algorithm.... {the calls count is just to see how efficient the caching is}

```perl
sub optimal_route {
  $calls++;
  my($start,@r) = @_;
  my $key = "$start @{[ sort @r ]}";
  return $CACHE{$key} if exists $CACHE{$key};
  my $len = 1e99;
  my $rt  = '';
  if(@r==1) { 
    $len = $dist_maps->[$start][$r[0]] + $dist_maps->[$r[0]][0];
    $rt = chr(65+$r[0]).'A';
  } else {
    foreach(0..$#r) {
      my $t = shift @r;
      my $x = optimal_route($t,@r);
      my $l = $dist_maps->[$start][$t] + $x->[0];
      if( $l < $len ) {
        $len = $l;
        $rt  = (chr(65+$t)).$x->[1];
      }
      push @r,$t;
    }
  }
  return $CACHE{$key} = [$len,$rt];
}
```

Running this for size 20 give us this output... {obv a randomised distance matrix}

```
Distance matrix:
      0    8    7   18    3   14    5   18   16   10    0   18    8    0   12    5    0    0    3    7
      3    0    7    0    3   17    8    5    0    7    6   19    8   13   14   18   19   15   11    7
      7   12    0   14   14    4   11   11   11    6    5   15   11    1    8   12   19    6   14   12
     19    1    5    0    5    7   11    3    7   17    8   14    8   12    4   18   17   15   19    7
     14    3    8   12    0    1   18    2    4   12    5   10    7    2   11   11   19    1    6    1
     10   17    6   14    4    0    9   12   13    7   19   14   16    1   12   13    3   18    9    7
     17    5    5    4   10    3    0   19    1   15   10    2   18    3    3    4   18   11   18    9
     15   12   12   15    5    6    5    0    0    5    6    6    0    2   16   10   10    4    9   18
      3   17    4    3    0    5   14   14    0   15   12    8   12    8   10    3    6   18    9   17
      6   13    5    2   12   15    5    5   13    0   12   16   12   18    8    6   12    3    9   18
     15   15   19    2    2   14    0   11   13   13    0   16   17   17    9    3   12    2   13    1
      4   18    5   18    9   10    9   13   16    2   15    0    0    8    1   19    5   18    5    6
      7   17    5    6   18    5   19   13    8   15   10    6    0    1    3    5   17    5    8    3
      5   19    3   16    6    5   16    3   16   18   17   18   10    0   17   18    8    4    4    8
      6   16   18    4   16    6    6    7    0   15   18    2    3   16    0   10   16    1   12    0
      9    3   17   18   12    5   12   10    1    3   17   19    3   13   16    0   13    9    8   11
     13    6   12   17    2    2    0   12    9    2   16    1   19   15   11    3    0   17    7    6
     13   12    9   13    3   17   16   10   10    7    7    1    7   11   14   10   12    0    4    7
     18   18   14   10   14    1    5   17    4    9    0   11   13    8   14   11   17   19    0    7
     14   14   17   13    2    5    6   12    8   11   12    6   19   18   16   10    1    5   11    0
Routes: 121,645,100,408,832,000
Calls:               44,826,302 { 1 :  2,713,699,212 }
Cache:                4,980,718 { 1 : 24,423,205,732 }
Length: 32
Route:  A R L O T Q G I E H M C F N S K P J D B A
Time:   181.083702 seconds
```

As you can see from the output the filtering is very efficient in this case quickly reducing the number
of routes investigated from 121 quadrillion to a handful of millions. The algorithm is "limited" by
memory as the cache grows rapidly as `$N` increases.
