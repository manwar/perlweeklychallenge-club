#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use List::Util 'none';

sub main {
    # Get all squares < 500
    my @squares = ();
    foreach my $i ( 2 .. 22 ) {
        push @squares, $i * $i;
    }

    # Find all numbers 1 .. 500 that aren't divisable by a square
    my @solutions = ();
    foreach my $i ( 1 .. 500 ) {
        if ( none { $i % $_ == 0 } @squares ) {
            push @solutions, $i;
        }
    }
    say join ', ', @solutions;
}

main();