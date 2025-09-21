#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics qw(combinations);
use List::Util               qw(max);

sub main (@ints) {
    my $solution = 0;

    # Compute all combinations of 4 integers
    my $iter = Algorithm::Combinatorics::combinations( \@ints, 4 );
    while ( my $c = $iter->next ) {
        # Calculate the maximum difference for this combination
        my $diff = max(
            abs( ( $c->[0] * $c->[1] ) - ( $c->[2] * $c->[3] ) ),
            abs( ( $c->[0] * $c->[2] ) - ( $c->[1] * $c->[3] ) ),
            abs( ( $c->[0] * $c->[3] ) - ( $c->[1] * $c->[2] ) ),
        );
        if ( $diff > $solution ) {
            $solution = $diff;
        }
    }
    say $solution;
}

main(@ARGV);
