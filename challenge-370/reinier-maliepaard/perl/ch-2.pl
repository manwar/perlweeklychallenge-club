#!/usr/bin/perl
use strict;
use warnings;
use Memoize;

# This implementation works well for small inputs: it is clear, self-contained,
# and uses memoization and anagram pruning to reduce redundant work.
#
# For larger inputs, switch to bottom-up dynamic programming (building a table
# from smaller substrings to larger ones using indices), avoiding substring
# copying (memory-intensive) and deep recursion.
#
# Also, encapsulate memoization for better modularity.
#
# In this version, Memoize is used instead of a manual %memo hash.
# It results in a cleaner function body.

memoize('is_scramble');

sub is_scramble {
    my ($s1, $s2) = @_;

    # Base cases
    # A scramble comparison only makes sense if both strings have the same length.
    return 0 if length($s1) != length($s2);

    # If the strings are identical, they are trivially scrambles.
    return 1 if $s1 eq $s2;

    # A one-character string has no possible split, so recursion stops here.
    # Since identical strings were already handled above, the remaining case is false.
    return 0 if length($s1) <= 1;

    my $n = length($s1);

    # Pruning step: anagram check
    # Two scrambles must contain the same characters with the same counts.
    my %count;

    $count{$_}++ for split //, $s1;
    $count{$_}-- for split //, $s2;

    # If any count is nonzero, the strings are not anagrams,
    # so they cannot be scrambles.
    return 0 if grep { $_ != 0 } values %count;

    # Recursive split search
    # Try every possible split position.
    # At each position, test the two valid scramble forms:
    # Case 1) no swap: left-left and right-right
    # Case 2) swap:    left-right and right-left

    for my $i (1 .. $n - 1) {

        # Case 1: no swap
        return 1
            if is_scramble(substr($s1, 0, $i), substr($s2, 0, $i))
            && is_scramble(substr($s1, $i),    substr($s2, $i));

        # Case 2: swapped halves
        return 1
            if is_scramble(substr($s1, 0, $i), substr($s2, $n - $i))
            && is_scramble(substr($s1, $i),    substr($s2, 0, $n - $i));
    }

    # If no split works, these strings are not scrambles.
    return 0;
}

# Tests

my ($str1, $str2);

# Example 1
$str1 = "abc";
$str2 = "acb";
printf "%s\n", is_scramble($str1, $str2) ? "true" : "false"; # Output: true

# Example 2
$str1 = "abcd";
$str2 = "cdba";
printf "%s\n", is_scramble($str1, $str2) ? "true" : "false"; # Output: true

# Example 3
$str1 = "hello";
$str2 = "hiiii";
printf "%s\n", is_scramble($str1, $str2) ? "true" : "false"; # Output: false

# Example 4
$str1 = "ateer";
$str2 = "eater";
printf "%s\n", is_scramble($str1, $str2) ? "true" : "false"; # Output: true

# Example 5
$str1 = "abcd";
$str2 = "bdac";
printf "%s\n", is_scramble($str1, $str2) ? "true" : "false"; # Output: false
