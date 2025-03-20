#!/usr/bin/env perl

# Challenge 313
#
# Task 2: Reverse Letters
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string.
#
# Write a script to reverse only the alphabetic characters in the string.
# Example 1
#
# Input: $str = "p-er?l"
# Output: "l-re?p"
#
# Example 2
#
# Input: $str = "wee-k!L-y"
# Output: "yLk-e!e-w"
#
# Example 3
#
# Input: $str = "_c-!h_all-en!g_e"
# Output: "_e-!g_nel-la!h_c"

use Modern::Perl;

say reverse_letters(shift);

sub reverse_letters {
    my($string) = @_;
    my @rev_letters = reverse grep {/[a-z]/i} split //, $string;
    my @output = split //, $string;
    for my $i (0 .. $#output) {
        next if $output[$i] !~ /[a-z]/i;
        $output[$i] = shift @rev_letters;
    }
    return join '', @output;
}

