#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say distance(@ARGV);

sub hamming_distance {
    my($a, $b) = @_;
    my $distance = 0;
    while ($a > 0 || $b > 0) {
        my $bit_a = $a & 1;
        my $bit_b = $b & 1;
        $distance++ if $bit_a != $bit_b;
        $a >>= 1;
        $b >>= 1;
    }
    return $distance;
}

sub distance {
    my(@nums) = @_;
    my $distance = 0;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            $distance += hamming_distance($nums[$i], $nums[$j]);
        }
    }
    return $distance;
}
