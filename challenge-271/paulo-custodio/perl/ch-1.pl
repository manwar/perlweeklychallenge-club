#!/usr/bin/env perl

# Perl Weekly Challenge 271 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/

use Modern::Perl;
use List::Util 'max';

my @matrix = split /,/, "@ARGV";
@matrix = map {[split ' ', $_]} @matrix;

say 1+max_ones(@matrix);

sub max_ones {
    my(@matrix) = @_;
    my @ones = map {tr/1/1/} map {join '', @$_} @matrix;
    my $max = max(@ones);
    for (0 .. $#ones) {
        return $_ if $ones[$_] == $max;
    }
    return 0;
}
