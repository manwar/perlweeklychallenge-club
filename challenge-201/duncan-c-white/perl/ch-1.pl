#!/usr/bin/perl
# 
# Task 1: Missing Numbers
# 
# You are given an array of unique numbers.  Write a script to find out
# all missing numbers in the range 0..$n where $n is the array size.
# 
# Example 1
# 
#   Input: @array = (0,1,3)
#   Output: 2
# 
#   The array size i.e. total element count is 3, so the range is 0..3.
#   The missing number is 2 in the given array.
# 
# Example 2
# 
#   Input: @array = (0,1)
#   Output: 2
# 
#   The array size is 2, therefore the range is 0..2.
#   The missing number is 2.
# 
# MY NOTES: pretty easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: missing-numbers [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

die "missing-slices: need at least 1 int in list\n" unless @list>0;

my $n = @list;

# so range is 0..$n

my %present = map { $_ => 1 } @list;
my @missing = grep { ! $present{$_} } 0..$n;
say join(',', @missing);
