#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';

sub main (@n) {
    my $solutions = 0;

    # Work through all combinations of positions
    my $iter = combinations( [ 0 .. $#n ], 4 );
    while ( my $x = $iter->next ) {
        my ( $i, $j, $k, $l ) = sort { $a <=> $b } @$x;
        if ( $n[$i] + $n[$j] + $n[$k] == $n[$l] ) {
            $solutions++;
            return;
        }
    }

    say $solutions;
}

main(@ARGV);
