#!/usr/bin/env perl

# Challenge 070
#
# TASK #2 › Gray Code Sequence
# Submitted by: Mohammad S Anwar
# You are given an integer 2 <= $N <= 5.
#
# Write a script to generate $N-bit gray code sequence.
#
# 2-bit Gray Code Sequence
# [0, 1, 3, 2]
# To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence,
# follow the step below:
#
# 2-bit Gray Code sequence
# [0, 1, 3, 2]
#
# Binary form of the sequence
# a) S1 = [00, 01, 11, 10]
#
# Reverse of S1
# b) S2 = [10, 11, 01, 00]
#
# Prefix all entries of S1 with '0'
# c) S1 = [000, 001, 011, 010]
#
# Prefix all entries of S2 with '1'
# d) S2 = [110, 111, 101, 100]
#
# Concatenate S1 and S2 gives 3-bit Gray Code sequence
# e) [000, 001, 011, 010, 110, 111, 101, 100]
#
# 3-bit Gray Code sequence
# [0, 1, 3, 2, 6, 7, 5, 4]
# Example
# Input: $N = 4
#
# Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]

use Modern::Perl;

my $N = shift||2;
say join(", ", gray($N));


sub gray {
    my($n) = @_;
    if ($n < 2) { die; }
    elsif ($n == 2) {
        return (0, 1, 3, 2);
    }
    else {
        # gray sequence of N-1
        my @prev = gray($n-1);
        # binary form to S1
        my @s1 = map {sprintf("%0*b", $n-1, $_);} @prev;
        # recerse to S2
        my @s2 = reverse @s1;
        # prexix S1 with 0
        @s1 = map {"0".$_} @s1;
        # prexix S2 with 1
        @s2 = map {"1".$_} @s2;
        # concatenate
        my @gray = (@s1, @s2);
        # convert to decimal
        @gray = map {eval "0b$_"} @gray;

        return @gray;
    }
}
