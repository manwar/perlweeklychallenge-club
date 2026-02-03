#!/usr/bin/env perl

# Challenge 315
#
# Task 1: Find Words
# Submitted by: Mohammad Sajid Anwar
# You are given a list of words and a character.
#
# Write a script to return the index of word in the list where you find the given character.
#
#
# Example 1
# Input: @list = ("the", "weekly", "challenge")
#        $char = "e"
# Output: (0, 1, 2)
#
# Example 2
# Input: @list = ("perl", "raku", "python")
#        $char = "p"
# Output: (0, 2)
#
# Example 3
# Input: @list = ("abc", "def", "bbb", "bcd")
#        $char = "b"
# Output: (0, 2, 3)

use Modern::Perl;

my @words = split ' ', <>;
chomp(my $char = <>);

say join ", ", indices_words($char, @words);

sub indices_words {
    my($char, @words) = @_;
    my @indices;
    for my $i (0 .. $#words) {
        if ($words[$i] =~ /$char/) {
            push @indices, $i;
        }
    }
    return @indices;
}
