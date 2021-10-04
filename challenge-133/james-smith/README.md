# Perl Weekly Challenge #133

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-133/james-smith/perl

# Task 1 - Integer Square Root

***You are given a positive integer `$N`. Write a script to calculate the integer square root of the given number.***

## The solution

We implement Newton's formulae to compute the integer square root.. This is the compact version.

```perl
sub find_root {
  my( $x, $y ) = ( my $n = shift ) >> 1;             ## $x is half $n rounded down...
  return $n unless $x;                               ## Return $n if it is <2 (i.e. 0 or 1)
  $x = $y while ( $y = ( $x + $n / $x ) >> 1 ) < $x; ## The crux - the next no is 1/2 of $x & $n/$x
  return $x;                                         ## Return value
}
```

# Task 2 - Smith Numbers

***Write a script to generate first 10 Smith Numbers in base 10.***

## Solution

We break the logic up into chunks and implement those in separate function. As we look at each
prime in turn we can effectively create a sieve to get the prime factors.

Here is the main code.
 * We check to see if the sum of digits is the same as the sum of primefactor digits {and that it is not prime}
 * We add this to the list if it is the case
 * Return when we have `$C` (`10`) in this case...
```perl
sub smith_numbers {
  my ( $C, $n, @sn ) = (shift,3);
  ( sum_digits( $n ) - sum map { sum_digits $_ } prime_factors( $n ) ) ||
  ( push @sn, $n                                                     ) &&
  ( @sn == $C                                                        ) &&
  ( return @sn                                                       ) while $n++;
}
```

And the support functions:
 * `sum` - Just sum an array;
 * `sum_digits` - Sum digits of number,
   We cache the digit sum for each number in `%ds`;
 * `prime_factors` - for a prime returns nothing, for a composite returns the factors,
   We keep a list of primes `@primes`, and also the prime factors for each composite `%comp`.
   
```perl
sub sum        { my $t = 0; $t+=$_ foreach @_; $t;          }
sub sum_digits { return $ds{$_[0]} ||= sum split //, $_[0]; }

sub prime_factors {
  my $N = shift;
  ( $N % $_) or ( return @{ $comp{$N} = [ $_, @{$comp{ $N / $_ }||[$N/$_]}] } ) foreach @primes;
  push @primes, $N;
  return;
}



```
