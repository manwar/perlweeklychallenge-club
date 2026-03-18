#!/usr/bin/env perl

# Perl Weekly Challenge 268 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/

use Modern::Perl;

say "(", join(", ", number_game(@ARGV)), ")";

sub number_game {
    my(@ints) = @_;
    my @out;
    while (@ints) {
        @ints = sort {$a <=> $b} @ints;
        push @out, $ints[1], $ints[0];
        splice @ints, 0, 2;
    }
    return @out;
}
