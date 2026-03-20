#!/usr/bin/env perl

# Perl Weekly Challenge 222 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-222/

use Modern::Perl;

my @ints = @ARGV;
say matching_members(@ints);

sub matching_members {
    my(@ints) = @_;

    my @sorted = sort {$a <=> $b} @ints;
    my $matching = scalar grep {$ints[$_]==$sorted[$_]} 0..$#ints;
    return $matching;
}
