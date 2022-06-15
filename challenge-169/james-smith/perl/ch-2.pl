#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(factor_exp gcd);
use Time::HiRes qw(time);

my $time = time;

# Factorise $n into prime factors, and count for each factor...
#
# e.g. 10800 has factors ( 2, 2, 2, 2, 3, 3, 3, 5, 5 ) or 2^4 3^3 5^2
#
# factor_exp returns a list of tuples - [ prime, exponent ]

# If any of the 2nd entries in each tuple are 1 then we skip to the next number
# as it isn't brilliant..
#
# To rule out perfect numbers we find the gcd of these values and if it is
# greater than one we have a perfect number and skip to the next
#
# We have a brilliant imperfect (or archilles) number.... so display it..
#
# To pretty print the archilles numbers - we use our counter, and display
# it alongside the number and the factorisation.

for( my( $n, $c, $MAX, @f ) = ( 2, 0, @ARGV ? $ARGV[0] : 1e2 ); $c<$MAX; $n++ ) {
  say sprintf '%6d: %15d = %s', ++$c, $n, join ' . ', map  { "$_->[0]^$_->[1]" } @f
    if 1 == gcd map { $_->[1] < 2 ? next : $_->[1] } @f = factor_exp $n;
}

warn 'Time taken: ', time-$time, "\n";

