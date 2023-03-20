#!/usr/bin/perl

# Challenge 198
#
# Task 1: Max Gap
# Submitted by: Mohammad S Anwar
# You are given a list of integers, @list.
#
# Write a script to find the total pairs in the sorted list where 2 consecutive
# elements has the max gap. If the list contains less then 2 elements then
# return 0.
#
#
# Example 1
# Input:  @list = (2,5,8,1)
# Output: 2
#
# Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
# Example 2
# Input: @list = (3)
# Output: 0

use Modern::Perl;

sub max_gap {
    my(@n)=@_;
    return 0 if @n<2;
    @n=sort @n;
    my $max_gap=0;
    my $gap_count=0;
    for my $i (0..$#n-1) {
        my $gap=$n[$i+1]-$n[$i];
        if ($gap>$max_gap) {
            $max_gap=$gap;
            $gap_count=1;
        }
        elsif ($gap==$max_gap) {
            $gap_count++;
        }
    }
    return $gap_count;
}

@ARGV or die "usage: ch-1.pl nums\n";
my @n=@ARGV;
say max_gap(@n);


