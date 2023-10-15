#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my $total    = 0;
    my @solution = ();

    foreach my $i (@ints) {
        $total += $i;
        push @solution, $total;
    }

    say '(', join( ', ', @solution ), ')';
}

main(@ARGV);