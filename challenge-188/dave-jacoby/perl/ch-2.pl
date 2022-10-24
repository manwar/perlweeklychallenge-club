#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Carp;

my @input = ( [ 5, 4 ], [ 4, 6 ], [ 2, 5 ], [ 3, 1 ], [ 7, 4 ], );

for my $input (@input) {
    my ( $x, $y ) = $input->@*;
    my $o = total_zero( $x, $y );
    say <<"END";
    Input:  \$x = $x, \$y = $y
    Output: $o
END
}

sub total_zero ( $x, $y ) {
    my $x_prime = $x;
    my $i       = 0;
    while ( $x != 0 && $y != 0 ) {
        my $lx = $x;
        my $ly = $y;
        if ( $x >= $y ) { $lx = $x - $y; }
        if ( $y >= $x ) { $ly = $y - $x; }
        $x = $lx;
        $y = $ly;
        $i++;
        croak 'Does Not Go To Zero' if $i > 100;
    }
    return $i;
}
