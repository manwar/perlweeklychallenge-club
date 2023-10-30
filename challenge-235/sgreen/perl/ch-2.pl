#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # For zeros in the list, double it
    my @solution = map { $_ ? $_ : ( 0, 0 ) } @ints;

    # Truncate the list, and print it
    splice( @solution, scalar(@ints) );
    say join ', ', @solution;
}

main(@ARGV);