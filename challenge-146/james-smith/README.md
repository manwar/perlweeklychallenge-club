[< Previous 145](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-145/james-smith) |
[Next 147 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-147/james-smith)
# Perl Weekly Challenge #146

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-146/james-smith

# Challenge 1 - 10001st Prime Number

***Write a script to generate the 10001st prime number.***

## The solution

We could use a Prime module, but finding primes is not that difficult so we will roll our own generator:

```perl
my @primes = (3);

for( my $c=5; @primes<10000; $c+=2 ) {
  ($_*$_>$c)?((push@primes,$c),last):$c%$_||last for @primes;
}

say $primes[-1];
```

The crux of the code is in the `for @primes` line. This sees if a given odd number is prime.

We loop through all the primes up to and including the square root of the value we are checking.
If we don't find a prime factor by then we push the new value to the primes list, and go on to
try the next number. If we find a
factor we skip the rest of the loop and go on to try the next number.

We stop when we have 10,000 records in the array (as we don't include the prime number 2 in the list),
so the last element is the 10,001st prime.

# Challenge 2 - Curious Fraction Tree

*** Can't really describe this - best to look at the image on the website at https://theweeklychallenge.org/blog/perl-weekly-challenge-146/.***

## The solution

We notice that:
  * if you have a top-heavy fraction then the parent has the same denominator, and the new demoninator is the difference between the numerator and denominator.
  * otherwise the numerator stays the same and the denominator becomes the difference between the numerator and denominator.
We repeat this until we get to the top of the tree where both the denominator and numerator are 1.

The stringify function just converts the tree into a single string (list of fractions) so we can test the tree code.
```perl
sub tree {
  my $tree = [[ my($n,$d)=@_ ]];
  push @{$tree}, [($n,$d)=$d>$n?($n,$d-$n):($n-$d,$d)] while $n>1||$d>1;
  $tree;
}

sub stringify {
  join q( ), map { "$_->[0]/$_->[1]" } @{$_[0]};
}
```

