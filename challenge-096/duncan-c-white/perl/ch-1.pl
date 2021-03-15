#!/usr/bin/perl
#
# Task 1: "Reverse Words
# 
# You are given a string $S.
# 
# Write a script to reverse the order of words in the given string. The
# string may contain leading/trailing spaces. The string may have more
# than one space between words in the string. Print the result without
# leading/trailing spaces and there should be only one space between words.
# 
# Example 1:
# 
# 	Input: $S = "The Weekly Challenge"
# 	Output: "Challenge Weekly The"
# 
# Example 2:
# 
# 	Input: $S = "    Perl and   Raku are  part of the same family  "
# 	Output: "family same the of part are Raku and Perl"
# "
# 
# My notes: looks straightforward.
# 

use strict;
use warnings;
use feature 'say';
use Data::Dumper;

die "Usage: reverse-words S\n" if @ARGV==0;
my $s = join(' ', @ARGV);

$s =~ s/^\s+//;
$s =~ s/\s+$//;
my @rw = reverse( split(/\s+/, $s ) );
say join(' ', @rw);
