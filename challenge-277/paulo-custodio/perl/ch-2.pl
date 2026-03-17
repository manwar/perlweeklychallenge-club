#!/usr/bin/env perl

# Perl Weekly Challenge 277 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/

use Modern::Perl;
use List::Util 'min', 'uniq';

my @ints = uniq @ARGV;
my $count = 0;
for my $i (0..$#ints-1) {
    for my $j ($i+1..$#ints) {
        $count++ if is_strong_pair($ints[$i], $ints[$j]);
    }
}

say $count;

sub is_strong_pair {
    my($a, $b) = @_;
    return 0 < abs($a-$b) && abs($a-$b) < min($a,$b);
}
