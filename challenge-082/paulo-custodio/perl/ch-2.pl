#!/usr/bin/perl

# Challenge 082
#
# TASK #2 › Interleave String
# Submitted by: Mohammad S Anwar
# You are given 3 strings; $A, $B and $C.
#
# Write a script to check if $C is created by interleave $A and $B.
#
# Print 1 if check is success otherwise 0.
#
# Example 1:
# Input:
#     $A = "XY"
#     $B = "X"
#     $C = "XXY"
#
# Output: 1
# EXPLANATION
# "X" (from $B) + "XY" (from $A) = $C
# Example 2:
# Input:
#     $A = "XXY"
#     $B = "XXZ"
#     $C = "XXXXZY"
#
# Output: 1
# EXPLANATION
# "XX" (from $A) + "XXZ" (from $B) + "Y" (from $A) = $C
# Example 3:
# Input:
#     $A = "YX"
#     $B = "X"
#     $C = "XXY"
#
# Output: 0

use strict;
use warnings;
use 5.030;

say interleaved(@ARGV);


sub interleaved {
    my($a, $b, $c) = @_;
    for my $i (0 .. length($a)) {
        if (substr($a,0,$i).$b.substr($a,$i) eq $c) {
            return 1;
        }
    }
    return 0;
}
