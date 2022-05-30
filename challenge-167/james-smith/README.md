[< Previous 166](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-166/james-smith) |
[Next 168 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith)

# The Weekly Challenge 167

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-167/james-smith

# Challenge 1 - Circular Prime

***Write a script to find out first 10 circular primes having at least 3 digits (base 10). A circular prime is a prime number with the property that the number generated at each intermediate step when cyclically permuting its (base 10) digits will also be prime.***

## Solution

```perl
my($p,$N,@res) = (99,10);
O: while( @res < $N ) {
  next O if ($p = next_prime $p)=~/[024568]/;
  my @q = split//, $p;
  push @res, $p unless
    ( grep { $p>$_ } @q = map { push @q, shift @q; join '',@q } 2..@q )
    || grep { !is_prime( $_ ) } @q;
}
say for @res;
```

# Challenge 2 - Gamma function

***Implement subroutine gamma() using the Lanczos approximation method.***

## Solution

```perl
sub gamma {
  my($i,$x,$z)=(0,$X,$_[0]);
  return ($z<=0 && abs($z-int$z)<$EP) ? 'inf'
       : $z < 0.5                     ? $PI / sin($PI*$z) * gamma( 1-$z )
       : (map({$x+=$_/($z+$i++)}@PV),abs(($i=$RP*($i=$z+@PV-1.5)**($z-0.5)*exp(-$i)*$x)-int$i)<$EP?int$i:$i)[-1]
       ;
}
```
