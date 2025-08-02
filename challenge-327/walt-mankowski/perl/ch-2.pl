#!/usr/bin/env perl
use v5.40;

my $min_dist = 1e300;
my @pairs;
my @elements = sort { $a <=> $b } @ARGV;

for my $i (0..$#elements-1) {
    for my $j ($i+1..$#elements) {
        my $delta = abs($elements[$i] - $elements[$j]);
        if ($delta < $min_dist) {
            @pairs = ([$elements[$i], $elements[$j]]);
            $min_dist = $delta;
        } elsif ($delta == $min_dist) {
            push @pairs, [$elements[$i], $elements[$j]];
        }
    }
}

for my $i (0..$#pairs) {
    printf "[%d,%d]", $pairs[$i][0], $pairs[$i][1];
    print ", " if $i < $#pairs;
}
say "";
