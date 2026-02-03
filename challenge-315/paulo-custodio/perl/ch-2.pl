#!/usr/bin/env perl

# Challenge 315
#
# Task 2: Find Third
# Submitted by: Mohammad Sajid Anwar
# You are given a sentence and two words.
#
# Write a script to return all words in the given sentence that appear in sequence to the given two words.
#
#
# Example 1
# Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
#        $first = "my"
#        $second = "favourite"
# Output: ("language", "too")
#
# Example 2
# Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
#        $first = "a"
#        $second = "beautiful"
# Output: ("doll", "princess")
#
# Example 3
# Input: $sentence = "we will we will rock you rock you.",
#        $first = "we"
#        $second = "will"
# Output: ("we", "rock")

use Modern::Perl;

my @words = split /\W+/, <>;
chomp(my $first = <>);
chomp(my $second = <>);

say join ", ", find_third($first, $second, @words);

sub find_third {
    my($first, $second, @words) = @_;
    my @third;
    for my $i (0 .. $#words-2) {
        if ($words[$i] eq $first && $words[$i+1] eq $second) {
            push @third, $words[$i+2];
        }
    }
    return @third;
}
