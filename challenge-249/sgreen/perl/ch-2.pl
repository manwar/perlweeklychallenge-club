#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main ($s) {
    # Start at zero
    my $d_count = 0;
    my $i_count = 0;
    my @solution = ( 0 );

    foreach my $c (split //, $s) {
        if ($c eq 'D') {
            # We want a lower number
            push @solution, --$d_count;
        }
        else {
            # We want a higher number
            push @solution, ++$i_count;
        }
    }

    # Rebase the list to start with zero
    @solution = map { $_ - $d_count } @solution;
    say join ', ', @solution;
}

main($ARGV[0]);