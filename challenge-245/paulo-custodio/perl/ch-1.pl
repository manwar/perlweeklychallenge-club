#!/usr/bin/env perl

# Challenge 245
#
# Task 1: Sort Language
# Submitted by: Mohammad S Anwar
#
# You are given two array of languages and its popularity.
#
# Write a script to sort the language based on popularity.
# Example 1
#
# Input: @lang = ('perl', 'c', 'python')
#        @popularity = (2, 1, 3)
# Output: ('c', 'perl', 'python')
#
# Example 2
#
# Input: @lang = ('c++', 'haskell', 'java')
#        @popularity = (1, 3, 2)
# Output: ('c++', 'java', 'haskell')

use Modern::Perl;

@ARGV or die "Usage: $0 lang pop lang pop ...\n";
my @lang;
while (@ARGV) {
    my($lang, $pop) = splice(@ARGV, 0, 2);
    push @lang, [$lang, $pop];
}
@lang = map {$_->[0]} sort {$a->[1] <=> $b->[1]} @lang;
say "@lang";
