#!/usr/bin/perl

# Challenge 197
#
# Task 2: Wiggle Sort
# Submitted by: Mohammad S Anwar
# You are given a list of integers, @list.
#
# Write a script to perform Wiggle Sort on the given list.
#
#
# Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….
#
#
# Example 1
# Input: @list = (1,5,1,1,6,4)
# Output: (1,6,1,5,1,4)
# Example 2
# Input: @list = (1,3,2,2,3,1)
# Output: (2,3,1,3,1,2)

use Modern::Perl;

sub copy_data {
    my($to, $to_idx, $from, $from_idx) = @_;
    for (; $to_idx >= 0; $to_idx-=2) {
        $to->[$to_idx]=$from->[$from_idx++];
    }
}

sub wiggle_sort {
    my(@nums) = @_;
    my @copy = sort {$a<=>$b} @nums;
    copy_data(\@nums, scalar(@nums)-2, \@copy, 0);
    copy_data(\@nums, scalar(@nums)-1, \@copy, int(scalar(@nums)/2));
    return @nums;
}

my @nums = wiggle_sort(@ARGV);
say "@nums";
