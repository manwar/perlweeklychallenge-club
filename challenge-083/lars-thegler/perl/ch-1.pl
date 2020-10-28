#! /usr/bin/env perl

use Modern::Perl;

# TASK #1 › Words Length
# Submitted by: Mohammad S Anwar
# You are given a string $S with 3 or more words.

# Write a script to find the length of the string except the first and last words ignoring whitespace.

# Example 1:
# Input: $S = "The Weekly Challenge"

# Output: 6
# Example 2:
# Input: $S = "The purpose of our lives is to be happy"

# Output: 23

my $S = shift; # get the string
my @W = split /\s+/, $S; # convert into words
die 'must be 3 or more words' unless @W >= 3; # check that it's long enough
shift @W; # drop the first word
pop @W; # drop the last word
my $length = length(join '', @W); # the length of the rest

say $length;