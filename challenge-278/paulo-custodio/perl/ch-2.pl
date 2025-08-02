#!/usr/bin/env perl

# Challenge 278
#
# Task 2: Reverse Word
# Submitted by: Mohammad Sajid Anwar
#
# You are given a word, $word and a character, $char.
#
# Write a script to replace the substring up to and including $char with its
# characters sorted alphabetically. If the $char doesn’t exist then DON'T do
# anything.
#
# Example 1
#
# Input: $str = "challenge", $char = "e"
# Ouput: "acehllnge"
#
# Example 2
#
# Input: $str = "programming", $char = "a"
# Ouput: "agoprrmming"
#
# Example 3
#
# Input: $str = "champion", $char = "b"
# Ouput: "champion"

use Modern::Perl;

@ARGV==2 or die "Usage: $0 word letter\n";
my($word, $letter) = @ARGV;

say $word =~ s{.*?$letter}{ join '', sort split //, $& }er;
