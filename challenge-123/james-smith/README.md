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
  state @uglies = (1);
  while(1) {
    return $uglies[$n-1] if $n <= @uglies;
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
  state ($l2,$l3,$l5,$v2,$v3,$v5,@uglies)=(0,0,0,2,3,5,1);
  return $uglies[$n-1] if $n <= @uglies;
  while( @uglies < $n ) {
    push @uglies, my $next = ($v2 < $v3 && $v2 < $v5) ? $v2 : ($v3 < $v5) ? $v3 : $v5;
    $v2 = $uglies[++$l2]*2 if $v2 == $next;
    $v3 = $uglies[++$l3]*3 if $v3 == $next;
    $v5 = $uglies[++$l5]*5 if $v5 == $next;
  }
  return $uglies[-1];
}

```

The extra overhead causes the optimized method to be slower than the simple method for low values of `$n` - but as `$n` goes up it saves many loop evaluations. Flip happens when `$n` is around `18` or `19`. By the time we get to `$n` as 1000 the optimized version is around 50 times faster than the naive one. For `$n = 10_0000` one of the largest values for which the ugly is less than 2^64 (and so all calculations are integer based) in around 600 times faster.

Below shows these comparisons - against a simple scan algorithm (with caching of uglies). We can see that for values up to around 20-30 the scan method (because of it's simplicity is fastest) and the uglies are relatively dense. But soon the advantage of our message is seen - by the time `$n` reaches 500 (Ugly is 937,500) to optimized
method is around 2000x faster than the scan method.

|      n |                    Ugly(n) | scan /s | simple /s |    opt /s | opt vs sim % | sim vs scn % | opt vs scn % |
| -----: | -------------------------: | ------: | --------: | --------: | -----------: | -----------: | -----------: |
|      1 |                          1 | 938,492 | 3,005,191 | 1,799,451 |          -40 |          220 |           92 |
|      2 |                          2 | 536,552 |   816,345 | 1,089,848 |           34 |           52 |          103 |
|      5 |                          5 | 234,116 |   238,716 |   455,051 |           91 |            2 |           94 |
|     10 |                         12 |  98,061 |    77,865 |   250,411 |          222 |          -21 |          155 |
|     20 |                         36 |  32,105 |    21,225 |   130,707 |          516 |          -34 |          307 |
|     50 |                        243 |   4,289 |     5,504 |    43,065 |          682 |           28 |          904 |
|    100 |                      1,536 |     724 |     1,203 |    24,768 |        1,959 |           66 |        3,321 |
|    200 |                     16,200 |   63.50 |       272 |    12,470 |        4,485 |          328 |       19,538 |
|    500 |                    937,500 |    0.57 |        48 |     4,639 |        9,565 |        8,306 |      812,334 |
|  1,000 |                 51,200,000 | -       |     10.60 |     2,503 |       23,513 | -            | -            |
|  2,000 |              8,062,156,800 | -       |      2.75 |     1,187 |       43,064 | -            | -            |
|  5,000 |         50,837,316,566,580 | -       |      0.41 |       375 |       91,812 | -            | -            |
| 10,000 |    288,325,195,312,500,000 | -       |      0.08 |       230 |      273,710 | -            | -            |
| 13,282 | 18,432,000,000,000,000,000 | -       |      0.05 |       148 |      302,757 | -            | -            |


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
