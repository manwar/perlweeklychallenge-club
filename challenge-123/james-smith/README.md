# Perl Weekly Challenge #123

You can find more information about this weeks, and previous weeks challenges at:

  https://perlweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-123/james-smith/perl

# Task 1 - Ugly Numbers

***You are given an integer `$n >= 1`. Write a script to find the $nth element of Ugly Numbers.***

**Defn:** Ugly numbers are those number whose prime factors are 2, 3 or 5. For example, the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.

## The solution

There are two ways of working out the *nth* ugly number - we either have to search all numbers starting at 1 counting ugly numbers -OR- do something more "intellegent".

The former works well for small `n`, but doesn't scale well as the ugly numbers become more sparse.

### Method

Any Ugly number is either a multiple of 2, 3 or 5 of another Ugly number. So to find the next ugly number we multiple all ugly numbers by 2, 3 or 5 and find the lowest value greater than the last ugly seen.

```perl
sub nth_ugly {
  my $n = shift;
  my @uglies = (1);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $l (5,3,2) {
      foreach(@uglies) {
        next if $_ * $l <= $uglies[-1];
        $next = $_*$l if !$next || $next > $_*$l;
        last;
      }
    }
    push @uglies, $next;
  }
}

```

We cache the values internally in the function - in the `state` variable `@uglies`

### Optimization

We can speed this up by short-cutting the inner loop - by remembering which was the first ugly failed the check `$_ * $l <= $uglies[-1]`.

```perl
sub nth_ugly_opt {
  my $n = shift;
  my @uglies = (1);
  my @starts = (0,0,0,0,0,0);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
    ## Get the next ugly....
    my $next = 0;
    foreach my $l (5,3,2) {
      foreach ( $starts[$l] .. $#uglies ) {
        next if $uglies[$_] * $l <= $uglies[-1];
        $starts[$l]=$_;
        $next = $uglies[$_]*$l if !$next || $next > $uglies[$_]*$l;
        last;
      }
    }
    push @uglies, $next;
  }
}
```

The extra overhead causes the optimized method to be slower than the simple method for low values of `$n` - but as `$n` goes up it saves many loop evaluations. Flip happens when `$n` is around `18` or `19`. By the time we get to `$n` as 1000 the optimized version is around 50 times faster than the naive one. For `$n = 10_0000` one of the largest values for which the ugly is less than 2^64 (and so all calculations are integer based) in around 600 times faster.

Below shows these comparisons - against a simple scan algorithm (with caching of uglies). We can see that for values up to around 20-30 the scan method (because of it's simplicity is fastest) and the uglies are relatively dense. But soon the advantage of our message is seen - by the time `$n` reaches 500 (Ugly is 937,500) to optimized
method is around 2000x faster than the scan method.

|   n    | Ugly(n)                 | Scan        | Simple      |   Optimized | Opt v simple | Opt v scan    | Simple v scan |
| -----: | ----------------------: | ----------: | ----------: | ----------: | -----------: | ------------: | ------------: | 
|      1 |                       1 | 1,693,446/s | 3,131,931/s | 1,922,126/s |         -39% |           14% |           14% |
|      2 |                       2 |   844,419/s | 1,019,073/s |   537,358/s |         -47% |          -36% |           21% |
|      5 |                       5 |   294,998/s |   287,307/s |   167,641/s |         -42% |          -43% |           -3% |
|     10 |                      12 |   121,349/s |   109,978/s |    78,936/s |         -28% |          -35% |          -11% |
|     20 |                      36 |    40,792/s |    35,257/s |    38,068/s |           5% |           -7% |          -11% |
|     50 |                     243 |     6,098/s |     6,656/s |    15,056/s |         126% |          148% |           10% |
|    100 |                   1,536 |       941/s |     1,653/s |     7,423/s |         349% |          688% |           76% |
|    200 |                  16,200 |      83.5/s |       395/s |     3,700/s |         843% |        4,333% |          374% |
|    500 |                 937,500 |       0.8/s |      58.8/s |     1,479/s |       2,417% |      185,492% |        7,273% |
|  1,000 |              51,200,000 |             |      13.8/s |       687/s |       4,866% | - | - |
|  2,000 |           8,062,156,800 |             |      3.35/s |       352/s |      10,402% | - | - |
|  5,000 |      50,837,316,566,580 |             |      0.49/s |       138/s |      28,036% | - | - |
| 10,000 | 288,325,195,312,500,000 |             |      0.11/s |      67.6/s |      57,754% | - | - |

# Task 2 - Square Points

***You are given coordinates of four points i.e. (x1, y1), (x2, y2), (x3, y3) and (x4, y4). Write a script to find out if the given four points form a square.***

## Solution.

First we need to think how we define a square - it has 4 sides of equal length and sides at right angles. If we want to define it terms of distances between points we have 4 pairs of points that are the same distance apart and two pairs of points which are at `sqrt(2)` times this distance.

We therefore measure the squares of the distances between the points, and collect them together. If the list of distances is 2, and the ratio of the squares of the distance is 2 then we have a square.

 * The `while/foreach` loops calculate the square of the distances between points, and stores these in the hash `%dist` where the distance is the key.
 * We flip the hash so that the keys become values and values become keys. This allows us to check to see if we have one length 4 times and one length 2 times, for belt and braces we check the ratio of the length of the diagonal vs the length of the edges of the sides to see that it is 2.

```perl
sub is_square {
  my @pts = @_;
  my %dist;
  while(@pts>1) {
    my $p = shift @pts;
    $dist{ ($p->[0]-$_->[0]) ** 2 + ($p->[1]-$_->[1]) ** 2 }++ foreach @pts;
  }
  my %flip = reverse %dist;
  return exists $flip{2} && exists $flip{4} && $flip{2} == 2*$flip{4} || 0;
}
```
