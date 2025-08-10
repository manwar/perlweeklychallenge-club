#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    my @solution = ();
    for my $i (@ints) {
        if ($i == 0) {
            # Duplicate the zero
            push @solution, 0;
        }
        push @solution, $i;
    }
    say join(', ', @solution[ 0 .. $#ints ]);
}

main(@ARGV);