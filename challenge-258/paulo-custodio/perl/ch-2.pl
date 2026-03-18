#!/usr/bin/env perl

# Perl Weekly Challenge 258 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/

use Modern::Perl;
use List::Util 'sum';

my($k, @ints) = @ARGV;
say sum
    map {$_->[1]}
    grep {num_ones($_->[0]) == $k}
    map {[$_, $ints[$_]]} 0 .. $#ints;

sub num_ones {
    my($n) = @_;
    my $bin = sprintf("%b", $n);
    my $ones = $bin =~ tr/1/1/;
    return $ones;
}
