#!/usr/bin/env perl

# Task 1: Equal Strings
# Submitted by: Mohammad Sajid Anwar
# 
# You are given three strings.
# You are allowed to remove the rightmost character of a string to make all equals.
# Write a script to return the number of operations to make it equal otherwise -1.
# 
# Example 1
# Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
# Output: 2
# 
# Operation 1: Delete "c" from the string "abc"
# Operation 2: Delete "b" from the string "abb"
# 
# Example 2
# Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
# Output: -1
# 
# Example 3
# Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
# Output: 3

use strict;
use warnings;

my $s1 = "abc"; my $s2 = "abb"; my $s3 = "ab";
remove_rightmost_to_make_equals($s1, $s2, $s3);

$s1 = "ayz"; $s2 = "cyz"; $s3 = "xyz";
remove_rightmost_to_make_equals($s1, $s2, $s3);

$s1 = "yza"; $s2 = "yzb"; $s3 = "yzc";
remove_rightmost_to_make_equals($s1, $s2, $s3);

exit 0;

sub remove_rightmost_to_make_equals {
    my ($s1, $s2, $s3) = @_;
    my ($os1, $os2, $os3) = @_;

    my $i = 0;
    while (1) {
        last
            if $s1 eq $s2 and $s2 eq $s3
               or
               length($s1) == 0;
        ($s1, $s2, $s3) = sort { length($b) <=> length($a) }
                          ($s1, $s2, $s3);
        chop $s1;
        $i++;
    }

    printf "'%s' '%s' '%s' -> %d\n",
            $os1, $os2, $os3, (length($s1) == 0) ? -1 : $i;
}
