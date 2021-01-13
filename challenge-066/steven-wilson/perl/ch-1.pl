#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 27 June 2020

use strict;
use warnings;
use feature qw/ say /;
use Test::More tests => 3;

ok( divide( 5,  2 ) == 2 );
ok( divide( -5, 2 ) == -3 );
ok( divide( -5, -2 ) == 2 );

sub divide {
    my ( $M, $N ) = @_;
    my ( $a, $b ) = ( abs($M), abs($N) );
    my $q = 0;
    while ( $a >= $b ) {
        $q++;
        $a -= $b;
    }
    if ( ( ( $M < 0 ) && ( $N > 0 ) ) || ( ( $N < 0 ) && ( $M > 0 ) ) ) {
        $q = -$q;
        $q-- if $a != 0; # if neg and has remainder, floor number
    }
    $q;
}
