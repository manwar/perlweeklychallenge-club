#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub total_zero {
    my ( $x, $y ) = @_;
    my $operations = 0;

    while ( $x != 0 && $y != 0 ) {
        if ( $x > $y ) {
            $operations += int( $x / $y );
            $x %= $y;
        }
        else {
            $operations += int( $y / $x );
            $y %= $x;
        }
    }

    return $operations;
}

is( total_zero( 5, 4 ), 5, 'Example 1' );
is( total_zero( 4, 6 ), 3, 'Example 2' );
is( total_zero( 2, 5 ), 4, 'Example 3' );
is( total_zero( 3, 1 ), 3, 'Example 4' );
is( total_zero( 7, 4 ), 5, 'Example 5' );

done_testing();
