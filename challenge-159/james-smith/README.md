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

*** You are given a positive number, `$n`. Write a script to compute Farey Sequence of the order `$n`. All rational numbers less than with with denominators less than `$n`

## The solution

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

***You are given a positive number `$n`. Write a script to generate the Moebius Number for the given number (see defn below)

## Definition

The value of the Moebius number is:

 * `0` if `$n` has a prime factor
 * `1` if the number has an even number of prime factors
 * `-1` otherwise

## The solution

```perl
sub moebius {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  $n%($p**2) ? ($n%$p && ($r=-$r)) : return 0 while ($p = next_prime $p) < $n;
  $r;
}
```

Expanding this out gives the more readable (but longer)...

```
sub moebius_exp {
  my ($n,$p,$r) = (shift,1,1);
  return -1 if is_prime($n);
  while( ($p = next_prime $p ) < $n ) {
    return 0 unless $n%($p**2);
    $r=-$r unless $n%$p;
  }
  $r;
}

```
