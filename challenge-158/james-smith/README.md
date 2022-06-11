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
use Math::Prime::Util qw(next_prime is_prime);

sub additive_primes {
  my @res;
  for(
    my $p = 2                                             ;
    my $s = 0,                        ( my $q = $p ) <= $N;
    (is_prime $s) && (push @res, $p), $p = next_prime $p
  ) {
    do { $s += $q % 10 } while $q = int $q / 10;
  }
  @res;
}
```
## Output
```
2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89
```
## Notes
 * We use a C-style `for` loop, with it's three parts *initialization*, *condition* and *increment*.
 * The *condition* and *increment* statements are complicated, each with two parts separated by `,`s.
 * The *condition* block is called at the start of each loop, and so we use it to initialise the variables as the loop, as well as checking the condition.
 * The *increment* block is called at the end of the loop and so stores the value of `$p` if it is an additive prime, then it increments the loop with the next prime.
 * Rather than doing a split and sum we use repeated dividing and summing, as it is more efficient around 20-30% more efficient. The increased performance is probably due to avoiding the "duality" of perl variables storing numbers as numbers/strings.

## Extra code

Rewritten with single line `for` ... (the original version of the code)

```perl
sub additive_primes_div {
  my @res;
  for(my$p=2; my$s=0,(my $q=$p)<=$N;(is_prime$s)&&(push@res,$p),$p=next_prime$p) {
    do { $s += $q % 10 } while $q = int $q / 10;
  }
  @res;
}
```

Alternative form with `for split`:

```perl
sub additive_primes_split {
  my @res;
  for( my $p = 2; my $s = 0, $p <= $N ; $p = next_prime $p ) {
    $s+=$_ for split //, $p;
    push @res, $p if is_prime $s;
  }
  @res;
}
```

And an alternate using `sum0`...

```perl
sub additive_primes_split_sum0 {
  my @res;
  for( my $p = 2; $p <= $N ; $p = next_prime $p ) {
    push @res, $p if is_prime sum0 split //, $p;
  }
  @res;
}
```

### Relative performance

 * `div`/`mod` method - 100%
 * `split`            -  75%
 * `sum0 split`       -  45%

# Challenge 2 - First series cuban primes

***Write a script to compute first series cuban primes <= 1000. (First series cuban primes have the form `((x+1)^3-x^3)/(x+1-x)` = `3x^2+3x+1`)***

## The solution

The solution is rather short. We try each of the value of the sequence `3*$x**2+3*$x+1` in turn up to the value of 1000 (`$N`).
We output each value which in turn is prime.

```perl
(is_prime $_) && say while $N >= ($_ = 3*$x*++$x+1);
```
## Output
```
7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919
```
## Notes
 * As we use `$_` as our temporary variable we can use `say` by itself to output it.
 * We use our common trick of `(condition) && (command)` to work as an `command if(condition)` which can be embedded in a postfix loop.
 * There is a "trick" as we increment `$x` half way through the calculation of `$_`.
   * `$_ = 3*$x**2 + 3*$x + 1` => `$_ = 3 * $x * ($x+1) + 1` => `$_ = 3 * $x * ++$x + 1`
   * We can replace the `$x+1` by the pre increment operator `++$x` so this becomes `3 * $x * ++$x + 1`.

## Aside

Second series cuban primes have the form `((x+2)^3-x^3)/(x+2-x)` = `3x^2+3.2x+4`. We can tweak the code to give:

```perl
(is_prime $_) && say while $N >= ($_ = 3 * $x * (2 + $x++) + 4);
```

which outputs:
```
13, 109, 193, 433, 769
```
