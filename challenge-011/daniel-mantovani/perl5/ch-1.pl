# Write a script that computes the equal point in the Fahrenheit and Celsius scales,
# knowing that the freezing point of water is 32 °F and 0 °C,
# and that the boiling point of water is 212 °F and 100 °C.
# This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use v5.10;

# we start by writing a function (to_f) that converts from
# celcius to farenheit. As it is a linear function, we
# have to take into account de relationship on increments
#
# From the description, we know that a change from 0 to 100
# celcius corresponde to a change from 32 to 212 farenheit,
# so 100 C <--> 180 F
# so to go from C to F we divide by 100, multiply by 180 and
# add 32.

sub to_f {
    return (shift) * 9 / 5 + 32;
}

# now as a response to the challenge, we just try the bisection
# method https://en.wikipedia.org/wiki/Bisection_method.
# (We could just solve the ecuation using standard math
# but that would't be a computer challenge I guess).
# we start with -1000 and +1000 as endpoints, and
# 1/1000000 as tolerance
# 10000 max iterations (although 50 is more than enough for this
# linear, simple case)

my ( $min, $max ) = ( -1000, 1000 );
my $tol  = 1 / 1_000_000;
my $nmax = 10_000;
my ( $c, $f, $found );

while ( $nmax-- ) {
    $c = ( $min + $max ) / 2;
    $f = to_f($c);
    $found++ && last if abs( $f - $c ) < $tol;
    my $fmin = to_f($min);

    # now compares signs of ($f - $c) vs ($fmin - $min) to decide
    # the new interval
    if ( $f > $c && $fmin > $min || $f < $c && $fmin < $min ) {
        $min = $c;
    }
    else {
        $max = $c;
    }
}

say $found
  ? sprintf "Solution found: %.3f Centigrades is %.3f Farenheit", $c, $f
  : "Error: no solution found";
