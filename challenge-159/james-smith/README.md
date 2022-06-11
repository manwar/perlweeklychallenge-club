[< Previous 156](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-156/james-smith) |
[Next 160 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-160/james-smith)
# The Weekly Challenge 159

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-159/james-smith

# Challenge 1 - Farey Sequence

***You are given a positive number, `$n`. Write a script to compute Farey Sequence of the order `$n`. All rational numbers less than with with denominators less than `$n`***

## The solution

This is a relatively simple piece of code - we loop through the denominators `1`..`$n` and compute all the fractions greater than 0 and less than or equal to 1.
We use the value as the key to the hash and "`$_/$d`" as the values.
We start with the lower denominators so if we find the same fraction twice (e.g. `1/2` & `2/4`) the value we always store has the lowest denominator and so the fraction is in its simplest form. A simple (key based) sort at the end and returning the list of strings of fractions...

```perl
sub farley {
  my($n,%v) = shift;
  for my $d (1..$n) {
    $v{$_/$d}||="$_/$d" for 1..$d;
  }
  map{$v{$_}}sort{$a<=>$b}keys%v;
}
```

# Challenge 2 - Moebius Number

***You are given a positive number `$n`. Write a script to generate the Moebius Number for the given number (see defn below)***

## Definition

The value of the Moebius number is:

 * `0` if `$n` has a prime factor
 * `1` if the number has an even number of prime factors
 * `-1` otherwise

## First pass... *naive* approach

```perl
sub moebius {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  $n%($p**2) ? ($n%$p && ($r=-$r)) : return 0 while ($p = next_prime $p) < $n;
  $r;
}
```

Here we just look for prime factors less than `$n` - for large `$n` - the number of primes checked is `$n/log $n`.

## Second pass... *first-pass* optimization

We can reduce the number of primes checked by reducing `$n` each time a prime is found, by dividing `$n` by the prime factor.

```perl
sub moebius_div {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  $n%($p**2) ? ( $n%$p || ($r=-$r,$n/=$p)) : return 0 while ($p = next_prime $p) && $n>1;
  $r;
}
```

## Third pass... *improved* performance

Finally we ideally want to restrict the number of primes checked further. We know that if `$n/$p` is prime we can stop there when looking for factors. It then also reduces the number primes to check to the square root of `$n`, so the maximum number of primes needed to check is `sqrt($n)/log $n/2`.

```perl
sub moebius_div_opt {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  $n%$p || ($n/=$p) && $n%$p ? ( is_prime $n ? (return $r) : ($r=-$r) ) : return 0 while ($p = next_prime $p)**2 <= $n;
  $r;
}
```

## Relative performance

On our extended test set the relative performance of the three methods is:

| Method  | Calls/second | Relative performance |
| :-----: | -----------: | -------------------: |
| simple  |     0.0025/s |                  1 x |
| divide  |        3.0/s |              1,200 x |
| div opt |     38,000/s |         16,000,000 x |

## Expanded version of optimal solution..

The format of the optimized code is compact - here is an expanded version of the code to show the logic.

```
sub moebius {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime $n;
  while( ($p = next_prime $p )**2 <= $n ) {
    next if $n%$p;
    $n/=$p;
    return 0 unless $n%$p;
    return $r if is_prime $n;
    $r=-$r;
  }
  $r;
}
```
