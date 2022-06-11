#!/usr/bin/env perl

# Challenge 051
#
# TASK #1
# 3 Sum
# Given an array @Lof integers. Write a script to find all unique triplets such
# that a + b + c is same as the given target T. Also make sure a <= b <= c.
#
# Here is wiki page for more information.
#
# Example:
#
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

use Modern::Perl;
use List::Util qw( sum );

my $target = 0;
say _3sum(@ARGV);

sub _3sum {
    my(@n) = @_;
    for my $i (0 .. $#n-2) {
        my $outi = $n[$i]<0 ? $n[$i] : "+".$n[$i];
        for my $j ($i+1 .. $#n-1) {
            my $outj = $n[$j]<0 ? $n[$j] : "+".$n[$j];
            for my $k ($j+1 .. $#n) {
                my $outk = $n[$k]<0 ? $n[$k] : "+".$n[$k];
                if (sum(@n[$i,$j,$k])==$target) {
                    return "$outi$outj$outk=$target";
                }
            }
        }
    }
    return "";
}
