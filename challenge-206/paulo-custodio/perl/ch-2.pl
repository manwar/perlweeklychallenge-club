#!/usr/bin/perl

# Challenge 206
#
# Task 2: Array Pairings
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers having even number of elements..
#
# Write a script to find the maximum sum of the minimum of each pairs.
# Example 1
#
# Input: @array = (1,2,3,4)
# Output: 4
#
# Possible Pairings are as below:
# a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
# b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
# c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
#
# So the maxium sum is 4.
#
# Example 2
#
# Input: @array = (0,2,1,3)
# Output: 2
#
# Possible Pairings are as below:
# a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
# b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
# c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
#
# So the maximum sum is 2.

use Modern::Perl;
use List::Util 'min', 'max', 'sum';

@ARGV % 2 == 0 && @ARGV >= 2 or die "Usage: ch-2.pl pairs...\n";
my @in = @ARGV;
my @pairs = all_pairs(@in);
my $max = 0;
for my $pair (@pairs) {
    my $sum = sum(map { min(@$_) } @$pair);
    $max = max($max, $sum);
}
say $max;

sub all_pairs {
    my(@in) = @_;
    my @pairs;
    compute_pairs(\@pairs, [], [@in]);
    return @pairs;
}

sub compute_pairs {
    my($pairs, $set, $pending) = @_;
    my @set = @$set;
    my @pending = @$pending;
    if (@pending) {
        for my $i (0..$#pending-1) {
            for my $j ($i+1..$#pending) {
                my @this_set = (@set, [$pending[$i], $pending[$j]]);
                my @this_pending = @pending;
                splice(@this_pending, $j, 1);
                splice(@this_pending, $i, 1);
                compute_pairs($pairs, \@this_set, \@this_pending);
            }
        }
    }
    else {
        push @$pairs, [@$set];
    }
}

