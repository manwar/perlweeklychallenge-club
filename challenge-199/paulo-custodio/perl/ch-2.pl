#!/usr/bin/perl

# Challenge 199
#
# Task 2: Good Triplets
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers, @array and three integers $x,$y,$z.
#
# Write a script to find out total Good Triplets in the given array.
#
# A triplet array[i], array[j], array[k] is good if it satisfies the following
# conditions:
#
# a) 0 <= i < j < k <= n (size of given array)
# b) abs(array[i] - array[j]) <= x
# c) abs(array[j] - array[k]) <= y
# d) abs(array[i] - array[k]) <= z
#
# Example 1
#
# Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
# Output: 4
#
# Good Triplets are as below:
# (3,0,1) where (i=0, j=1, k=2)
# (3,0,1) where (i=0, j=1, k=3)
# (3,1,1) where (i=0, j=2, k=3)
# (0,1,1) where (i=1, j=2, k=3)
#
# Example 2
#
# Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
# Output: 0

use Modern::Perl;

sub count_good_triplets {
    my(@in) = @_;
    my $z = pop @in;
    my $y = pop @in;
    my $x = pop @in;
    my $count = 0;
    for my $i (0..$#in-2) {
        for my $j ($i+1..$#in-1) {
            for my $k ($j+1..$#in) {
                $count++ if (abs($in[$i] - $in[$j]) <= $x &&
                             abs($in[$j] - $in[$k]) <= $y &&
                             abs($in[$i] - $in[$k]) <= $z);
            }
        }
    }
    return $count;
}

say count_good_triplets(@ARGV);
