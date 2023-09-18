#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';

sub main (@ints) {
    # Calculate the frequency of all integers
    my %freq = ();
    foreach my $i (@ints) {
        $freq{$i}++;
    }

    if ( scalar( keys %freq ) < 3 ) {
        say 0;
        return;
    }

    my $solutions = 0;
    my $iter      = combinations( [ keys %freq ], 3 );
    while ( my $c = $iter->next ) {
        my ( $i, $j, $k ) = @$c;
        # The number of solutions of this combination the product of the frequencies
        $solutions += $freq{$i} * $freq{$j} * $freq{$k};

    }

    say $solutions;
}

main(@ARGV);