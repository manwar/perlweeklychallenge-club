#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

# I admit, I had to look at other versions, such as
# the Rosetta Code version to understand what's going
# on here. https://rosettacode.org/wiki/Fusc_sequence#Perl

# the OEIS columnar explanation did me no favors, because
# I kept thinking that N had some relation to row number,
# which is not so much true and necessary.

# we're given a clear explanation where fusc(n) == n when 0 < n < 2
# (although spread out into two lines) and fusc(n/2) if even and
# fusc( (n-1 )/ 2 ) + fusc( (n+2) / 2 ) if odd.

# I REALLY need to make the "This looks like a Job for RECURSION!"
# swag some day.

say join ', ', map { fusc($_) } 0 .. 60;

sub fusc ( $n ) {

    # fusc(0) = 0
    # fusc(1) = 1
    return $n if $n < 2;

    # when n is even: fusc(n) = fusc(n / 2),
    return fusc( int $n / 2 ) if $n % 2 == 0;

    # when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
    return fusc( int( $n - 1 ) / 2 ) + fusc( ( $n + 1 ) / 2 );
}

exit;
