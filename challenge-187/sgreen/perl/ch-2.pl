#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Algorithm::Combinatorics 'combinations';
use List::Util 'sum';

sub main (@array) {
    my $solution = [];

    # Calculate for all combinations
    my $combinations = combinations( \@array, 3 );
    while ( my $new = $combinations->next ) {
        my ( $x, $y, $z ) = @$new;
        if ( $x + $y > $z and $y + $z > $x and $x + $z > $y ) {
            if ( scalar(@$solution) == 0 or sum(@$new) > sum(@$solution) ) {
                $solution = [ sort { $b <=> $a } @$new ];
            }
        }
    }

    if ( scalar(@$solution) == 0 ) {
        say '()';
    }
    else {
        say '(', join( ', ', @$solution ), ')';
    }
}

main(@ARGV);