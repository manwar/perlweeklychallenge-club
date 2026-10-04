#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

use Algorithm::Combinatorics 'combinations';

sub main ($n) {
    my $count = 0;

    if ($n == 1) {
        # Prevent Parameter k is greater than the size of data warning
        say 0;
        return;
    }
    # Generate all combinations
    my $iter = combinations( [ 1 .. $n ], 2 );

    # Loop through all combinations of 1 <= i < j <= n
    while ( my $combination = $iter->next ) {
        my ( $i, $j ) = @$combination;
        # Check that 'k' is an integer and less than or equal to 'n'
        my $k = sqrt( $i**2 + $j**2 );
        if ( $k == int($k) and $k <= $n ) {
            # We add two to count the opposite a and b values
            $count += 2;
        }
    }

    # Return the result
    say $count;
}

main(@ARGV);
