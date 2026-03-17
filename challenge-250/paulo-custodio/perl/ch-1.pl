#!/usr/bin/env perl

# Perl Weekly Challenge 250 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/

use Modern::Perl;

say smallest_index(@ARGV);

sub smallest_index {
    my(@ints) = @_;
    for my $i (0 .. $#ints) {
        return $i if ($i % 10) == $ints[$i];
    }
    return -1;
}
