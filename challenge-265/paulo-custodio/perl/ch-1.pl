#!/usr/bin/env perl

# Perl Weekly Challenge 265 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/

use Modern::Perl;

my @ints = @ARGV;
say freq_33(@ints);

sub freq_33 {
    my(@ints) = @_;
    my %count; $count{$_}++ for @ints;
    for my $n (sort {$a <=> $b} keys %count) {
        return $n if $count{$n}/scalar(@ints) >= 1/3;
    }
    return "''";
}
