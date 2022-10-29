#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

sub total_zero {
    my ( $x, $y ) = @_;
    my $count;

    do {
        $x -= $y, $count++ if $x > $y;
        $y -= $x, $count++ if $y >= $x;
    } until $x == 0 or $y == 0;

    return $count;
}

# Testing...
my @xys = ( [ 5, 4 ], [ 4, 6 ], [ 2, 5 ], [ 3, 1 ], [ 7, 4 ] );

my $expected = [ 5, 3, 4, 3, 5 ];
my $result;

push @$result, $_ for map { total_zero( @$_ ) } @xys;
is_deeply( $result, $expected, "Correct nb of ops to make ZEROES?" );

done_testing( 1 );
