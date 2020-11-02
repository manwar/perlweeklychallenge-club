#!/usr/bin/perl

use strict;
use warnings;

#Example 1 - Output: 1
my @input = ( [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 1 ] );

#Example 2 - Output: 4
#my @input = ( [ 1, 1, 0, 1 ], [ 1, 1, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] );

#Example 3 - Output: 0
#my @input = ( [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 0, 0, 1 ] );

my $squares = 0;

for my $row ( 0 ... $#input ) {
    for my $col ( 0 .. $#{ $input[$row] } ) {
        if ( $input[$row][$col] == 1 ) {
            $squares += get_squares( $row, $col );
        }
    }
}

print "Output: $squares\n";

sub get_squares {
    my ( $r, $c ) = @_;

    my $square_count = 0;

    for my $top_right ( $c + 1 .. $#{ $input[$r] } ) {

        my $bottom_row = $r + $top_right - $c;

        if (   $bottom_row < scalar @input
            && $input[$r][$top_right] == 1
            && $input[$bottom_row][$c] == 1
            && $input[$bottom_row][$top_right] == 1 )
        {
            $square_count++;
        }
    }

    return $square_count;
}
