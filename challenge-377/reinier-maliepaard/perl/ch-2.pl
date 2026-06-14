#!/usr/bin/perl
use strict;
use warnings;

# Problem:
# Count pairs (i, j) where i < j such that:
# - $arr[i] is a prefix of $arr[j]
# - $arr[i] is also a suffix of $arr[j]
#
# Complexity:
# Let n = number of strings
# Let m = length of current candidate prefix
#
# Time: O(n^2 · m)
# Space: O(1)

# Notes:
# - Uses substr instead of regex for performance and clarity.
# - Avoids repeated length() and array dereferencing.
# - Early exits reduce average-case work.

# O(n^2 · m) is perfectly reasonable when:
# - n is moderate (typical scripting use cases)
# - strings are not huge
# - simplicity matters more than scaling to millions of inputs

sub prefix_suffix {
    my ($arr) = @_;
    my $count = 0;

    my $n = @$arr;

    for (my $i = 0; $i < $n; $i++) {

        my $s1 = $arr->[$i];
        my $m  = length($s1);

        for (my $j = $i + 1; $j < $n; $j++) {

            my $s2 = $arr->[$j];

            # Quick rejection: cannot match if too short
            next if length($s2) < $m;

            # Check prefix first (cheap fail case)
            next if substr($s2, 0, $m) ne $s1;

            # Check suffix only if prefix matches
            $count++ if substr($s2, -$m) eq $s1;
        }
    }

    return $count;
}

# Tests

my @array;

# Example 1
@array = ("a", "aba", "ababa", "aa");
print prefix_suffix(\@array), "\n"; # Output: 4

# Example 2
@array = ("pa", "papa", "ma", "mama");
print prefix_suffix(\@array), "\n"; # Output: 2

# Example 3
@array = ("abao", "ab");
print prefix_suffix(\@array), "\n"; # Output: 0

# Example 4
@array = ("abab", "abab");
print prefix_suffix(\@array), "\n"; # Output: 1

# Example 5
@array = ("ab", "abab", "ababab");
print prefix_suffix(\@array), "\n"; # Output: 3

# Example 6
@array = ("abc", "def", "ghij");
print prefix_suffix(\@array), "\n"; # Output: 0
