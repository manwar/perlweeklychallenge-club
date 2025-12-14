#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Math::BigFloat;

sub main (@ints) {
    # Sort the list and compute the difference between the first two
    my @sorted_ints = map { Math::BigFloat->new($_) } sort { $a <=> $b } @ints;
    my $diff        = $sorted_ints[1] - $sorted_ints[0];

    # Check that each subsequent difference is the same
    foreach my $i ( 2 .. $#sorted_ints ) {
        if ( $sorted_ints[$i] - $sorted_ints[ $i - 1 ] != $diff ) {
            say 'false';
            return;
        }
    }

    say 'true';
}

main(@ARGV);
