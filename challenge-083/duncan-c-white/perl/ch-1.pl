#!/usr/bin/perl
#
# Task 1: "Words Length
#
# You are given a string $S with 3 or more words.
# 
# Write a script to find the length of the string except the first and
# last words ignoring whitespace.
# 
# Example 1:
# 	Input: $S = "The Weekly Challenge"
# 	Output: 6
# 
# Example 2:
# 	Input: $S = "The purpose of our lives is to be happy"
# 	Output: 23
#	ME: WRONG! length(purpose of our lives is to be)==29
# 
# My notes: simple, clearly defined: use the power of regexes.
#

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: words-length s\n" unless @ARGV;
my $s = join( ' ', @ARGV );

my $orig = $s;

$s =~ s/^\S+\s+//;	# remove first word
$s =~ s/\s+\S+$//;	# remove last word

say "orig:$orig, s:$s:", length($s);
