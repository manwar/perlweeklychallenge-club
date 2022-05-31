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

*We are going to slightly extend this to find the first 19 circular primes - includes 4 1-digit primes and 5 2-digit circular primes and the 10 3+-digit ciruclar primes < one-million - After the largest 6-digit circular prime the next circular prime is the 19 digit prime - 1,111,111,111,111,111,111*

We use `Math::Prime::Util`s `next_prime` function to loop through the primes. Before we check for primality of each of the permutations we can remove trivial cases:
 
 * We know all 1-digit primes are circular so we take these out first `#1` - in fact the remaining logic does not work as we assume there are other rotations - and the regex we see next would remove `2` & `5` the only primes that contain either of these digits;
 * We then remove numbers containing `0`, `2`, `4`, `5`, `6` or `8` as at least one rotation would end in this digit and therefore the number sould not be prime;
 * As we are looking for an exemplar for each rotation we take the lowest one - we just check that the supplied prime is less than any of the rotations.

   **Note** we use next here to short cut the map and jump to the next loop element.

   In this line we use `@q` to initially be the individual digits, but at the end we reuse it to conatain all the rotations.

 * Now we look to see if we have any non-primes in the rotation using `is_prime`.. If we do then we skip the loop

 * Finally if we have got through all the filters we push the prime `$p` on to the results array.>

```perl
use Math::Prime::Util qw(next_prime is_prime);
my( $p, $N, @q, @res ) = ( 1, 19 );

while( @res < $N ) {
  ( ( $p = next_prime $p ) < 10 #1
    || $p !~ /[024568]/
    && ( @q = split//, $p )
    && ( @q = map { push @q, shift @q; ( $_ = join '', @q ) < $p ? (next) : $_ } 2..@q )
    && ( ! grep { ! is_prime( $_ ) } @q )
  ) && ( push @res, $p )
}

say for @res;
```

# Challenge 2 - Gamma function

***Implement subroutine gamma() using the Lanczos approximation method.***

## Solution

The gamma function is the genaralisation of the factorial function `Gamma(n) = (n-1)!` for positive integers.

We will use Lanczos approximation...

 * If z is an integer and less than or equal to 0 - we return the special string 'inf' as the value is infinite.
 * If z is less than 0.5 - we use the calulation beased on `gamma(1-z)` multiplied the the factor `PI/sin(PI * z)`
 * Finally we use the lanczos approximation.
   * This starts by computing the sum in the map, then computing the value based on this sum
   * we use `( map( {} @PV ), fn(z,x) )[-1]` to put this all in one line, we also re-use `$i` after the loop, to store the value of `$z+@PV-1.5` which is used twice AND again to store the final value - so we can decide to round it back down to an integer if we are close to integer value. This I agree is nasty!!!
   * `$RP` is `sqrt(2*$PI)` but evaluated for speed 
 
```perl
const my $PI => 3.1415926535897932384626433832;
const my $RP => 2.5066282746310002416123552393;
const my $EP => 0.000000000001;
const my $X  => 0.99999999999980993;
const my @PV => (
  676.5203681218851,  -1259.1392167224028,    771.32342877765313,     -176.61502916214059,
   12.507343278686905,   -0.13857109526572012,  9.9843695780195716e-6,   1.5056327351493116e-7,
);

sub gamma {
  my($i,$x,$z)=(0,$X,$_[0]);
  ( $z<=0 && abs( $z - int$z ) < $EP ) ? 'inf'
  : $z < 0.5                     ? $PI / sin( $PI * $z ) * gamma( 1 - $z )
  : ( map( { $x += $_ / ( $z + $i++ ) } @PV ),
      abs( ( $i = $RP * ( $i = $z + @PV - 1.5 ) ** ( $z - 0.5 ) * $x * exp -$i ) - int $i
    ) < $EP ? int $i : $i )[-1]
}
```
