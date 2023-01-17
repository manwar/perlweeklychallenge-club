#!/usr/bin/env perl
use strict;
use warnings;

# You are given an array of integers.
# 
# Write a script to find out all Arithmetic Slices for the given array of integers.
# An integer array is called arithmetic if it has at least 3 elements and the differences between any three consecutive elements are the same.
# 
# 
# Example 1
# Input: @array = (1,2,3,4)
# Output: (1,2,3), (2,3,4), (1,2,3,4)
# 
# Example 2
# Input: @array = (2)
# Output: () as no slice found.


my @list = @ARGV;
my @slices;
if (scalar @list >= 3) {
    foreach my $i (0..$#list-2) {
        my $bool_slice = 1;
        foreach my $seq ($i+2..$#list) {
            my @slice = map { $list[$_] }
                            $i..$seq;
            foreach my $j (2..$#slice) {
                if ($slice[1] - $slice[0] != $slice[$j]-$slice[$j-1]) {
                    $bool_slice = 0;
                    last;
                }
            }
            push @slices,
                sprintf '(%s)', join ',', @slice
                    if $bool_slice;
            last
                if $bool_slice == 0;
        }
    }
}

if (@slices) {
    printf 'Output: %s', join ', ', @slices;
} else {
    print 'Output: () as no slice found.';
}
