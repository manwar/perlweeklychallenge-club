#!/usr/bin/env perl

# Challenge 074
#
# TASK #2 › FNR Character
# Submitted by: Mohammad S Anwar
# You are given a string $S.
#
# Write a script to print the series of first non-repeating character (left
# -> right) for the given string. Print # if none found.
#
# Example 1
# Input: $S = ‘ababc’
# Output: ‘abb#c’
# Pass 1: “a”, the FNR character is ‘a’
# Pass 2: “ab”, the FNR character is ‘b’
# Pass 3: “aba”, the FNR character is ‘b’
# Pass 4: “abab”, no FNR found, hence ‘#’
# Pass 5: “ababc” the FNR character is ‘c’
#
# Example 2
# Input: $S = ‘xyzzyx’
# Output: ‘xyzyx#’
# Pass 1: “x”, the FNR character is “x”
# Pass 2: “xy”, the FNR character is “y”
# Pass 3: “xyz”, the FNR character is “z”
# Pass 4: “xyzz”, the FNR character is “y”
# Pass 5: “xyzzy”, the FNR character is “x”
# Pass 6: “xyzzyx”, no FNR found, hence ‘#’

use Modern::Perl;

my $s = shift||"";
say lnr_char($s);

sub lnr_char {
    my($s) = @_;
    my @s = split //, $s;
    my $out = "";
    my %seen;
    for my $i (0 .. $#s) {
        my $letter = $s[$i];
        $seen{$letter}++;
        my $found;
        for my $j (reverse 0 .. $i) {
            $letter = $s[$j];
            if ($seen{$letter} == 1) {
                $out .= $letter;
                $found = 1;
                last;
            }
        }
        if (!$found) {
            $out .= "#";
        }
    }
    return $out;
}
