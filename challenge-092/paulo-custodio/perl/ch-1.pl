#!/usr/bin/perl

# Challenge 092
#
# TASK #1 › Isomorphic Strings
# Submitted by: Mohammad S Anwar
# You are given two strings $A and $B.
#
# Write a script to check if the given strings are Isomorphic. Print 1 if they
# are otherwise 0.
#
# Example 1:
# Input: $A = "abc"; $B = "xyz"
# Output: 1
# Example 2:
# Input: $A = "abb"; $B = "xyy"
# Output: 1
# Example 3:
# Input: $A = "sum"; $B = "add"
# Output: 0

use strict;
use warnings;
use 5.030;

say isomorphic(@ARGV);

sub isomorphic {
    my($a, $b) = @_;

    # both strings must be the same size
    if (!defined($a) || !defined($b) || length($a) != length($b)) {
        return 0;
    }

    # convert each string to a list and check the mapping
    my(%mapping, %mapped);
    my @a = split(//, $a);
    my @b = split(//, $b);
    while (@a) {
        my $a = shift @a;
        my $b = shift @b;
        if (!$mapping{$a}) {            # a is new
            if ($mapped{$b}) {          # b already mapped to some other a
                return 0;
            }
            else {                      # store mapping
                $mapping{$a} = $b;
                $mapped{$b} = 1;
            }
        }                               # a already occurred
        else {
            if ($mapping{$a} ne $b) {   # previous mapping is different
                return 0;
            }
        }
    }
    return 1;
}
