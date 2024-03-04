#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # The last value is $k
    my $k = pop(@ints);

    my $total = 0;
    while ( my ( $pos, $value ) = each @ints ) {
        # Count the number of ones in the position value
        my $ones = ( sprintf( '%b', $pos ) =~ tr/1/1/ );
        if ( $k == $ones ) {
            # If it matches the 'k', add the value to the total
            $total += $value;
        }
    }

    say $total;
}

main(@ARGV);