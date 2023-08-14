#!/usr/bin/env perl

# Task 2: Count Words
# Submitted by: Mohammad S Anwar
# 
# You are given an array of words made up of alphabetic characters and a prefix.
# Write a script to return the count of words that starts with the given prefix.
#
# Example 1
# 
# Input: @words  = ("pay", "attention", "practice", "attend")
#        $prefix = "at"
# Ouput: 2
# 
# Two words "attention" and "attend" starts with the given prefix "at".
# 
# Example 2
# Input: @words  = ("janet", "julia", "java", "javascript")
#        $prefix = "ja"
# Ouput: 3
# 
# Three words "janet", "java" and "javascripr" starts with the given prefix "ja".

use strict;
use warnings;

my @input = ("pay", "attention", "practice", "attend");
my $prefix = "at";
count_words(\@input, $prefix);

@input = ("janet", "julia", "java", "javascript");
$prefix = "ja";
count_words(\@input, $prefix);

exit 0;

sub count_words {
    my $words = shift || [];
    my $prefix = shift || '';

    printf "Output: %d\n", scalar map { $_ =~ /^$prefix/}
                                    @$words;
    return undef;
}
