#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-051/
# Task #1
#
# 3 Sum
# Given an array @L of integers. Write a script to find all unique triplets
# such that a + b + c is same as the given target T. Also make sure a <= b <= c.
#
# Here is wiki page for more information.
# https://en.wikipedia.org/wiki/3SUM
#
# Example:
#
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

use strict;
use warnings;

use constant TARGET => 0;

my $integers = join ',', @ARGV;
my @L = sort { $a <=> $b } grep {/-?\d+/} split /,/, $integers;

die "At least 3 integers are needed" if @L < 3;

my $triplets;
for my $i (0 .. $#L - 2) {
    for my $j ($i+1 .. $#L - 1) {
        for my $k ($j+1 .. $#L) {
            next unless $L[$i] + $L[$j] + $L[$k] == TARGET;
            my $key = join '#', $L[$i], $L[$j], $L[$k];
            $triplets->{$key}++;
        }
    }
}

print 'Triplets for target '.TARGET."\n";
printf "(%s,%s,%s)\n", split /#/ foreach keys %$triplets;

__END__

./ch-1.pl -25, -10, -7, -3, 2, 4, 8, 10
Triplets for target 0
(-7,-3,10)
(-10,2,8)

./ch-1.pl 1 2 -3 -3 -1 -1
Triplets for target 0
(-1,-1,2)
(-3,1,2)
