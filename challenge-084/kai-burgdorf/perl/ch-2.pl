#!/usr/bin/perl

use strict;
use warnings;

#Example 1 - Output: 1
my @input = ( [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 1 ] );

#Example 2 - Output: 4
#my @input = ( [ 1, 1, 0, 1 ], [ 1, 1, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] );

#Example 3 - Output: 0
#my @input = ( [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 0, 0, 1 ] );

my $size    = scalar @{ $input[0] };
my $squares = 0;

my $r = 0;
for my $row (@input) {
    my $c = 0;
    for my $elem ( @{$row} ) {
        if ( $elem == 1 ) {
            $squares += get_squares( $r, $c );
        }
        $c++;
    }
    $r++;
}

print "Output: $squares\n";

sub get_squares {
    my ( $r, $c ) = @_;

    my $square_count = 0;
    my @row          = @{ $input[$r] };

    for my $top_right ( $c + 1 .. $#row ) {

        my $bottom_row = $r + $top_right - $c;

        if (   $bottom_row < $size
            && $input[$r][$top_right] == 1
            && $input[$bottom_row][$c] == 1
            && $input[$bottom_row][$top_right] == 1 )
        {
            $square_count++;
        }
    }

    return $square_count;
}
