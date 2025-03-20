#!/usr/bin/env perl

# Task 2: Reverse Letters
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string.
# Write a script to reverse only the alphabetic characters in the string.
# 
# Example 1
# Input: $str = "p-er?l"
# Output: "l-re?p"
#
# Example 2
# Input: $str = "wee-k!L-y"
# Output: "yLk-e!e-w"
#
# Example 3
# Input: $str = "_c-!h_all-en!g_e"
# Output: "_e-!g_nel-la!h_c"

use strict;
use warnings;

my $str = "p-er?l";
reverse_only_characters($str);

$str = "wee-k!L-y";
reverse_only_characters($str);

$str = "_c-!h_all-en!g_e";
reverse_only_characters($str);

exit 0;

sub reverse_only_characters {
    my $str = shift;

    my @old_str = reverse
                  map { /[[:alpha:]]/ ? $_ : ()}
                    split //, $str;
    my @new_str;
    foreach my $i (0..length($str)-1) {
        my $char = substr $str, $i, 1;
        if ($char =~ /[[:alpha:]]/) {
            push @new_str, ( shift @old_str);
        } else {
            push @new_str, $char;
        }
    }
    printf "'%s' -> '%s'\n",
        $str,
        join '', @new_str;
}
