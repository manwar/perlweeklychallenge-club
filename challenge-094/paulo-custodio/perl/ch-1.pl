#!/usr/bin/perl

# Challenge 094
#
# TASK #1 › Group Anagrams
# Submitted by: Mohammad S Anwar
# You are given an array of strings @S.
#
# Write a script to group Anagrams together in any random order.
#
# An Anagram is a word or phrase formed by rearranging the letters of a
# different word or phrase, typically using all the original letters exactly
# once.
#
# Example 1:
#     Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
#     Output: [ ("bat", "tab"),
#               ("saw", "was"),
#               ("top", "pot", "opt") ]
# Example 2:
#     Input: ("x")
#     Output: [ ("x") ]

use strict;
use warnings;
use 5.030;

# get list of words
my @words = @ARGV;

# sort the words by groups having the same letters
my %groups;
for my $word (@words) {
    my $key = word_key($word);
    $groups{$key} ||= [];
    push @{$groups{$key}}, $word;
}

my @output;
for my $group (sort keys %groups) {
    push @output, "(".join(", ", map {'"'.$_.'"'} @{$groups{$group}}).")";
}
say "[ ", join(",\n  ", @output), " ]";


sub word_key {
    my($word) = @_;
    $word =~ s/\W//g;
    my @letters = sort split //, lc($word);
    return join '', @letters;
}
