#!/usr/bin/env perl

# Perl Weekly Challenge 324 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/

use Modern::Perl;

my @nums = split ' ', <>;
my($rows, $cols) = split ' ', <>;
my @m;
for my $r (0 .. $rows-1) {
    $m[$r] = [];
    for my $c (0 .. $cols-1) {
        $m[$r][$c] = shift @nums;
    }
}
say join ", ", map {"[$_]"} map {join ", ", @$_} @m;
