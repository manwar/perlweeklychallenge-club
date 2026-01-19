#!/usr/bin/env perl

# Challenge 342
#
# Task 1: Balance String
# Submitted by: Mohammad Sajid Anwar
# You are given a string made up of lowercase English letters and digits only.
#
# Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.
#
#
# Example 1
# Input: $str = "a0b1c2"
# Output: "0a1b2c"
#
# Example 2
# Input: $str = "abc12"
# Output: "a1b2c"
#
# Example 3
# Input: $str = "0a2b1c3"
# Output: "0a1b2c3"
#
# Example 4
# Input: $str = "1a23"
# Output: ""
#
# Example 5
# Input: $str = "ab123"
# Output: "1a2b3"

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";

say balance($ARGV[0]);

sub balance {
    my ($str) = @_;

    # Separate and sort characters for lexicographical order
    my @letters = sort grep { /[a-z]/ } split //, $str;
    my @digits  = sort grep { /[0-9]/ } split //, $str;

    my $l_count = scalar @letters;
    my $d_count = scalar @digits;

    # Check if a balanced arrangement is impossible
    return "" if abs($l_count - $d_count) > 1;

    # Determine the starting pool
    # If counts are unequal, the larger group MUST start.
    # If counts are equal, both can start; pick the smaller character.
    my $next_pool;
    if ($l_count > $d_count) {
        $next_pool = \@letters;
    }
    elsif ($d_count > $l_count) {
        $next_pool = \@digits;
    }
    else {
        # Counts are equal: pick the smaller of the two first available chars
        $next_pool = ($letters[0] le $digits[0]) ? \@letters : \@digits;
    }

    my $out = "";
    my @pools = ($next_pool == \@letters) ? (\@letters, \@digits) : (\@digits, \@letters);

    # Alternatingly build the string
    while (@{$pools[0]} || @{$pools[1]}) {
        return "" if !@{$pools[0]}; # Safety check
        $out .= shift @{$pools[0]};
        @pools = reverse @pools;    # Swap pools for the next character
    }

    return $out;
}
