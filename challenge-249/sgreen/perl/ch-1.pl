#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub main (@ints) {
    my %freq = ();
    foreach my $i (@ints) {
        ++$freq{$i};
    }

    if (any {$_ % 2 == 1 } values(%freq)) {
        say '()';
        return;
    }

    my @solution = ();
    foreach my $i (keys %freq) {
        foreach (1 .. $freq{$i} / 2) {
            push @solution, "($i, $i)";
        }
    }

    say join ', ', @solution;
}

main(@ARGV);