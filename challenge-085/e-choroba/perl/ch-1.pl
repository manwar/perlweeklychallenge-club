#!/usr/bin/perl
use warnings;
use strict;

sub triplet_sum {
    my @arr = sort { $a <=> $b } grep $_ < 2, @_;
    return 0 if @arr < 3
             || $arr[0]  * 3 >= 2
             || $arr[-1] * 3 <= 1;

    for my $A (0 .. $#arr - 2) {
        return 0 if $arr[$A] * 3 >= 2;
        next if $arr[$A] + $arr[-1] + $arr[-2] <= 1;

        for my $B ($A + 1 .. $#arr - 1) {
            my $sAB = $arr[$A] + $arr[$B];
            return 0 if $sAB + $arr[$B + 1] >= 2;
            last     if $sAB + $arr[-1]     <= 1;

            for my $C ($B + 1 .. $#arr) {
                my $s = $sAB + $arr[$C];
                return 1 if 1 < $s && $s < 2;
            }
        }
    }
    return 0
}

use Test::More tests => 6;

is triplet_sum(1.2, 0.4, 0.1, 2.5), 1, 'Example 1';
is triplet_sum(0.2, 1.5, 0.9, 1.1), 0, 'Example 2';
is triplet_sum(0.5, 1.1, 0.3, 0.7), 1, 'Example 3';

is triplet_sum(0.1, 0.1, 0.1, 0.1, 1.9, 1.9, 1.9, 1.9), 0;
is triplet_sum(0.9, 1.0, 1.1), 0;
is triplet_sum(0.3, 0.33, 0.333), 0;
