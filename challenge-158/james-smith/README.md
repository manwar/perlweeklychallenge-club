[< Previous 157](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-157/james-smith) |
[Next 159 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-159/james-smith)
# The Weekly Challenge 158

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-158/james-smith

# Challenge 1 - Additive primes

***Additive primes are prime numbers for which the sum of their decimal digits are also primes.***

## The solution

```perl
sub additive_primes {
  my @res;
  for( my $p = 2; (my $s=0) || (my $q=$p)<=$N; $p = next_prime $p ) {
    do { $s += $q%10 } while $q = int $q/10;
    push @res, $p if is_prime $s;
  }
  @res;
}
```

# Challenge 2 - First Series Cuban Primes

***Write a script to compute first series Cuban Primes <= 1000. (First series cuban primes have the form `3x^2+3x+1`)***

## The solution

```perl
for(
  my $x = 1;
  ( my $y = 3 * $x * ($x+1) + 1 ) <= $N;
  $x++
) {
  say $y if is_prime $y;
}
```

