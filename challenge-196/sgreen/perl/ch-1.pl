#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';

sub main (@n) {
    # Work through all combinations of positions
    my $iter = combinations( [ 0 .. $#n ], 3 );
    while ( my $x = $iter->next ) {
        my ( $i, $j, $k ) = sort { $a <=> $b } @$x;
        if ( $n[$i] < $n[$k] < $n[$j] ) {
            say "($n[$i], $n[$j], $n[$k])";
            return;
        }
    }

    # No solution is found
    say '()';
}

main(@ARGV);