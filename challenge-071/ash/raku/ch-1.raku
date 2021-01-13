#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/

# Comments: https://andrewshitov.com/2020/08/01/raku-challenge-week-71/

my $n = 20;
my @data = map {50.rand.Int}, ^$n;
say @data;

my @peaks = map {@data[$_]}, grep {
    @data[$_ - 1] < @data[$_] > @data[$_ + 1]
}, 1 .. $n - 2;
say @peaks;
