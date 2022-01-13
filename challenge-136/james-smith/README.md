[< Previous 135](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-135/james-smith) |
[Next 137 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-137/james-smith)

# Perl Weekly Challenge #136


You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-136/james-smith/perl

# Task 1 -  Two friendly

***You are given 2 positive numbers, `$m` and `$n`. Write a script to find out if the given two numbers are "Two friendly".***

*Two positive numbers, `m` and `n` are two friendly when `gcd(m, n) = 2 ^ p` where `p > 0`. The greatest common divisor (gcd) of a set of numbers is the largest positive number that divides all the numbers in the set without remainder.*

## The solution

The logic of our solution is (1) find the GCD; (2) check they are not co-prime (GCD = 1); (3) The GCD is a power of 2

We can test the last case by converting the GCD into binary - and checking to see if it has the form `10+`. Alternatively we can use `&` and `>>=` to remove trailing zeros.

All that gives us the simple function....

```perl
sub friendly {
  my($a,$b) = @_;
  ($a,$b) = ($b,$a%$b) while $b; ## Compute GCD
  return 0 if $a == 1;           ## Co-prime not friendly
  $a>>=1 until $a&1;             ## Remove trailing 0s
  return $a == 1 ? 1 : 0;        ## Friendly iff
}

```

# Task 2 - Fibonacci Sequence

***You are given a positive number `$n`. Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.***

## Solution

There are two bits to this:
 * get a list of fibonacci numbers `<= $n`. Easier to find list up to the first fibonnaci number `> $n`.
   * We have a cache of the fibonnaci numbers - we just need to extend it to include all those fibonnaci numbers below `$n` (if required).
 * get a list of sums of these numbers which equal `$n`
   * We call a generic "get-sum" method where we pass in our target number and array of fibonacci numbers
   * this get-sum method is then call recursively to count the number of totals
 
```perl

my @fib;

sub fib_sum {
  my $n = shift;
  push @fib, $fib[-1] + $fib[-2] while $n > $fib[-1];
  return sum( $n, grep { $_ <= $n }  @fib );
}

sub sum {
  local $_;
  my ( $t, @n ) = @_;
  return 1 unless $t;
  return 0 if $t < 0;
  my $c = 0;
  $c += sum( $t - $_, @n ) while $_ = shift @n;
  return $c;
}

```
