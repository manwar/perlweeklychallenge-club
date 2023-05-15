#!/usr/bin/env perl

use v5.36;

say "challenge-215-task1";

# Task 1: Odd one Out
# You are given a list of words (alphabetic characters only) of same size.
# Write a script to remove all words not sorted alphabetically and print the number of words in the list that are not alphabetically sorted. 

# Example 1
# Input: @words = ('abc', 'xyz', 'tsu')
# Output: 1

# Example 2
# Input: @words = ('rat', 'cab', 'dad')
# Output: 3

# Example 3
# Input: @words = ('x', 'y', 'z')
# Output: 0

sub odd_one_out {
    my @words = @{+shift};
    my $char = '';
    my $out = 0;
    say "Input: @words";
    for my $word (@words) {
        for my $c (split '', $word) {
            if ($char lt $c) {
                $char = $c;
            } else {
                $out += 1;
                last;
            }
        }
    }
    say "Output: $out";
}

while (<DATA>) {
    chomp;
    my @words = split ',';
    odd_one_out(\@words);
}


__DATA__
abc,xyz,tsu
rat, cab,dad
x,y,z
