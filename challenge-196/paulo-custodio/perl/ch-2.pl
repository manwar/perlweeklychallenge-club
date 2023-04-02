#!/usr/bin/perl

# Challenge 196
#
# Task 2: Range List
# Submitted by: Mohammad S Anwar
# You are given a sorted unique integer array, @array.
#
# Write a script to find all possible Number Range i.e [x, y] represent range
# all integers from x and y (both inclusive).
#
#
# Each subsequence of two or more contiguous integers
#
#
# Example 1
# Input: @array = (1,3,4,5,7)
# Output: [3,5]
# Example 2
# Input: @array = (1,2,3,6,7,9)
# Output: [1,3], [6,7]
# Example 3
# Input: @array = (0,1,2,4,5,6,8,9)
# Output: [0,2], [4,6], [8,9]

use Modern::Perl;

sub range_list {
    my(@n)=@_;
    my @ranges;
    my $s=0;
    while ($s<@n) {
        my $i=0;
        while ($s+$i<@n && $n[$s]+$i==$n[$s+$i]) {
            $i++;
        }
        if ($i>1) {
            push @ranges, [@n[$s, $s+$i-1]];
            $s+=$i;
        }
        else {
            $s++;
        }
    }
    return @ranges;
}

@ARGV or die "usage: ch-1.pl nums...\n";
my @n=@ARGV;
my @ranges=range_list(@n);
say "(",join(", ", map {"[".$_->[0].",".$_->[1]."]"} @ranges),")";
