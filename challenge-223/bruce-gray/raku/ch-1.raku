# https://en.wikipedia.org/wiki/Prime-counting_function
sub π ( UInt $n --> UInt ) {
    # Too slow:
    # state @π = lazy [\+] map &is-prime, 0..Inf;
    # return @π[$n];

    return +grep &is-prime, 2..$n;
}


my @tests =
    ( 10, 4 ),
    (  1, 0 ),
    ( 20, 8 ),

    # From https://oeis.org/A006880  Number of primes < 10^n.
    ( 10¹,          4),
    ( 10²,         25),
    ( 10³,        168),
    ( 10⁴,       1229),
    ( 10⁵,       9592),
    ( 10⁶,      78498),
    ( 10⁷,     664579),
    ( 10⁸,    5761455),     # 100 seconds to calc.

    # No time this week to implement https://en.wikipedia.org/wiki/Prime-counting_function#The_Meissel%E2%80%93Lehmer_algorithm
    # ( 10⁹,   50847534),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is π($in), $expected;
}
