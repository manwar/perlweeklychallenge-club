#!/usr/bin/perl
# 
# Task 2: Trim List
# 
# You are given list of numbers, @n and an integer $i.
# Write a script to trim the given list where element is less than or
# equal to the given integer.
# 
# Example 1
# 
# Input: @n = (1,4,2,3,5) and $i = 3
# Output: (4,5)
# 
# Example 2
# 
# Input: @n = (9,0,6,2,3,8,5) and $i = 4
# Output: (9,6,8,5)
# 
# MY NOTES: also looks incredibly easy, basically grep { $_ >= $i }.
# Just to bulk the task up a little, I allowed the input list to be
# spread across multiple arguments, each of which can either store a
# simple +ve int, or a comma-separated list of one or more +ve ints.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: trim-list [--debug] I List\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my $i = shift;

# all remaining arguments should be single ints, or
# comma-separated lists of ints.
my $all = join(',',@ARGV);
$all =~ s/\s+/,/g;
my @list = split(/,/, $all);

# now do the trimming, in-place:
@list = grep { $_ >= $i } @list;
say '('.join(',', @list ).')';
