#!/usr/bin/env perl

# Challenge 221
#
# Task 1: Good Strings
# Submitted by: Mohammad S Anwar
#
# You are given a list of @words and a string $chars.
#
#     A string is good if it can be formed by characters from $chars, each
#     character can be used only once.
#
#
# Write a script to return the sum of lengths of all good strings in words.
#
# Example 1
#
# Input: @words = ("cat", "bt", "hat", "tree")
#        $chars = "atach"
# Output: 6
#
# The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.
#
# Example 2
#
# Input: @words = ("hello", "world", "challenge")
#        $chars = "welldonehopper"
# Output: 10
#
# The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.

use Modern::Perl;

my @words = @ARGV;
my $chars = pop(@words);
my $result = 0;
for my $word (@words) {
    $result += length($word) if is_good_string($word, $chars);
}
say $result;

sub is_good_string {
    my($word, $chars) = @_;
    for my $ch (split //, $chars) {
        $word =~ s/$ch//i;
    }
    return $word eq '';
}
