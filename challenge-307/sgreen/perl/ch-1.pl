#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Sort the lists numerically
    my @sorted_ints = sort { $a <=> $b } @ints;
    my @differences = ();

    foreach my $idx ( 0 .. $#ints ) {
        if ( $ints[$idx] != $sorted_ints[$idx] ) {
            # If the value in the original list and sorted list at this
            #  position is different, add it to the differences list.
            push @differences, $idx;
        }
    }

    # Return the list
    say '(', join( ', ', @differences ), ')';
}

main(@ARGV);
