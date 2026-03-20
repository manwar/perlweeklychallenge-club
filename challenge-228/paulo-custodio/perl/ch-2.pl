#!/usr/bin/env perl

# Perl Weekly Challenge 228 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-228/

use Modern::Perl;
use List::Util 'min';

my @ints = @ARGV;
say count_ops(@ints);

sub count_ops {
    my(@ints) = @_;
    my $ops = 0;
    while (@ints) {
        if (min(@ints)==$ints[0]) {
            shift @ints;
        }
        else {
            push @ints, shift @ints;
        }
        $ops++;
    }
    return $ops;
}
