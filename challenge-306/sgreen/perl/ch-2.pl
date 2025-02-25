#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    while ( $#ints > 0 ) {
        # Sort the list, and remove the last two elements
        @ints = sort { $a <=> $b } @ints;
        my $x = pop(@ints);
        my $y = pop(@ints);

        if ( $x != $y ) {
            # If the last two elements, append the difference to the ints
            #  array. We know that x is greater than y, always.
            push @ints, $x - $y;
        }
    }

    say $#ints == 0 ? $ints[0] : 0;
}

main(@ARGV);
