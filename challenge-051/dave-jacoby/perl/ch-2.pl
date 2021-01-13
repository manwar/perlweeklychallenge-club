#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures };
no warnings qw{ experimental::postderef experimental::signatures };

for my $i ( 100 ... 999 ) {
    say $i if is_colorful($i);
}

# the important part is splitting the 3-digit number into separate
# digits, then comparing the parts alone and multiplied in combination

# making another function that tests color of an abstractly-large
# number, rather than hard-coding for three digits is a topic for
# another time.

sub is_colorful( $d ) {
    my %test;

    my ( $i, $j, $k ) = split //, $d;    # 263 becomes 2,6,3

    # I'm told that using map as a cheat array is dirty pool
    # but it makes this a bit cleaner.

    # we make an anonymous array with all the products, and then
    # use map to add them into the hash. ++$var iterates before
    # use, so $test{$_} goes up by one, then is tested.

    map { return 0 if ++$test{$_} > 1; } $i, $j, $k, ( $i * $j ),
        ( $j * $k ), ( $i * $j * $k );

    return 1;
}
