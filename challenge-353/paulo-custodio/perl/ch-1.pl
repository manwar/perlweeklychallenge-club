#!/usr/bin/env perl

# Challenge 353
#
# Task 1: Max Words
# Submitted by: Mohammad Sajid Anwar
# You are given an array of sentences.
#
# Write a script to return the maximum number of words that appear in a single sentence.
#
# Example 1
# Input: @sentences = ("Hello world", "This is a test", "Perl is great")
# Output: 4
#
# Example 2
# Input: @sentences = ("Single")
# Output: 1
#
# Example 3
# Input: @sentences = ("Short", "This sentence has seven words in total", "A B C", "Just four words here")
# Output: 7
#
# Example 4
# Input: @sentences = ("One", "Two parts", "Three part phrase", "")
# Output: 3
#
# Example 5
# Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question")
# Output: 10

use Modern::Perl;

@ARGV or die "usage: $0 sentences...\n";
my @words = sort {$a<=>$b} map {scalar @$_} map {[split ' ', $_]} @ARGV;
say $words[-1];
