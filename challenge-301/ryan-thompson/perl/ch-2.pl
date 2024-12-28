#!/usr/bin/env perl

use 5.038;

sub hamming($x,$y) { ()= sprintf('%b', $x ^ $y) =~ /1/g }

sub hamming_multi(@ints) {
    my $dist = 0;

    for my $i (0..$#ints-1) {
        $dist += hamming($ints[$i], $_) for @ints[$i+1..$#ints];
    }

    $dist;
}

say hamming_multi(@ARGV) and exit if @ARGV;
