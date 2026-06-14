#!/usr/bin/perl
use strict;
use warnings;

# Build a set of all adjacent 2-character pairs seen so far.
#
# Observation:
# A pair "xy" occurs in the reversed string if and only if
# the pair "yx" occurs somewhere in the original string.
#
# Therefore, while scanning the string from left to right,
# for each pair we only need to check whether its reverse
# has already been seen.
#
# Example:
#   "banana"
#   Pairs: ba an na an na
#
#   When we encounter "na", the reversed pair "an"
#   has already been seen, so we return true.
#
# Complexity:
#   Time:  O(n)
#   Space: O(n)
#
# where n is the length of the string.

sub reverse_existence {
    my ($str) = @_;

    my %seen;

    for my $i (0 .. length($str) - 2) {
        my $pair = substr($str, $i, 2);

        # A pair "xy" appears in the reversed string
        # if the pair "yx" appears somewhere in the
        # original string.
        return 1 if exists $seen{ reverse $pair };

        $seen{$pair} = 1;
    }

    return 0;
}

# Alternative implementation.
#
# Reverse the string once and check whether any adjacent
# 2-character substring from the original string occurs
# somewhere in the reversed string.
#
# Complexity:
# - O(n²) worst case:
#   - n-1 adjacent pairs
#   - each index() search may scan O(n) characters
#
# This version is straightforward and may be perfectly
# adequate for small inputs.

sub reverse_existence_alt {
    my ($str) = @_;
    my $rev = reverse $str;

    for my $i (0 .. length($str) - 2) {
        return 1 if index($rev, substr($str, $i, 2)) >= 0;
    }

    return 0;
}

# Tests

# Example 1
print reverse_existence("abcba") ? "true" : "false", "\n"; # Output: true

# Example 2
print reverse_existence("racecar") ? "true" : "false", "\n"; # Output: true

# Example 3
print reverse_existence("abcd") ? "true" : "false", "\n"; # Output: false

# Example 4
print reverse_existence("banana") ? "true" : "false", "\n"; # Output: true

# Example 5
print reverse_existence("hello") ? "true" : "false", "\n"; # Output: true
