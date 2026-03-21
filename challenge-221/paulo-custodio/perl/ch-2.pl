#!/usr/bin/env perl

# Perl Weekly Challenge 221 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-221/

use Modern::Perl;
use List::Util 'max';

my @ints = @ARGV;
my $max_sequence = 0;
for my $i (0 .. $#ints-1) {
    for my $j ($i+1 .. $#ints) {
        my $sequence = find_sequence($ints[$i], @ints[$j .. $#ints]);
        $max_sequence = max($max_sequence, $sequence);
    }
}
say $max_sequence;

sub find_sequence {
    my(@ints) = @_;
    @ints >= 2 or die;
    my $cur = shift @ints;
    my $delta = $ints[0] - $cur;
    my $sequence = 1;
    while (@ints) {
        my $next = $cur+$delta;
        while (@ints && $ints[0] != $next) {
            shift @ints;
        }
        if (@ints) {
            $cur += $delta;
            shift @ints;
            $sequence++;
        }
    }
    return $sequence;
}
