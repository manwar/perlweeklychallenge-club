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

We loop through each prime p, work out the digit sum (by repeated modulo 10/divide by 10) and check that it is prime.
We craft this as two loops - an outer `for` loop and an inner `do {} while`.

```perl
sub additive_primes {
  my @res;
  for( my $p = 2; my $s=0, (my $q=$p)<=$N; $p = next_prime $p ) {
    do { $s += $q%10 } while $q = int $q/10;
    push @res, $p if is_prime $s;
  }
  @res;
}
```

# Challenge 2 - First Series Cuban Primes

***Write a script to compute first series Cuban Primes <= 1000. (First series cuban primes have the form `3x^2+3x+1`)***

## The solution

The solution is rather short. We try each of the value of the sequence `3*$x**2+3*$x+1` in turn up to the value of 1000 (`$N`).
We output each value which in turn is prime.

```perl
(is_prime $_) && say while $N >= ($_ = 3*$x*++$x+1);
```
### Notes
 * As we use `$_` as our temporary variable we can use `say` by itself to output it.
 * We use our common trick of `(condition) && (command)` to work as an `command if(condition)` which can be embedded in a postfix loop.
 * There is a "trick" as we increment `$x` half way through the calculation of `$_`.
   * `$_ = 3*$x**2 + 3*$x + 1` => `$_ = 3 * $x * ($x+1) + 1` => `$_ = 3 * $x * ++$x + 1`
   * We can replace the `$x+1` by the pre increment operator `++$x` so this becomes `3 * $x * ++$x + 1`.
