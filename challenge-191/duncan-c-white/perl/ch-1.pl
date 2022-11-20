#!/usr/bin/perl
# 
# Task 1: Twice Largest
# 
# You are given list of integers, @list.
# 
# Write a script to find out whether the largest item in the list is at
# least twice as large as each of the other items.
# 
# Example 1
# 
# Input: @list = (1,2,3,4)
# Output: -1
# 
# The largest in the given list is 4.
# However 4 is not greater than (dcw:OR EQUAL TO) twice remaining element 3:
# 2 x 3 >  4
# 
# Example 2
# 
# Input: @list = (1,2,0,5)
# Output: 1
# 
# The largest in the given list is 5.
# Also 5 is greater than (dcw:OR EQUAL TO) twice of every remaining element.
# 1 x 2 <= 5
# 2 x 2 <= 5
# 0 x 2 <= 5
# 
# Example 3
# 
# Input: @list = (2,6,3,1)
# Output: 1
# 
# The largest in the given list is 6.
# Also 6 is greater than (dcw:OR EQUAL TO) twice of every remaining element.
# 2 x 2 <= 6
# 3 x 2 <= 6
# 1 x 2 <= 6
# 
# Example 4
# 
# Input: @list = (4,5,2,3)
# Output: -1
# 
# The largest in the given list is 5.
# Also 5 is not greater than (dcw:OR EQUAL TO) twice of every remaining element.
# 4 x 2 >  5
# 2 x 2 <= 5
# 3 x 2 >  5
# 
# MY NOTES: very easy, although there's an error in the wording of the examples
# above - to get eg3 to "succeed" (have result 1) it's got to be "max element
# is >= every other element * 2"...
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use List::Util qw(max);

my $debug=0;
die "Usage: twice-largest [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @x = split(/,/, join(',', @ARGV) );
my $max = max(@x);
my @exceptmax = grep { $_ ne $max } @x;

my $n = grep { $max < 2 * $_ } @exceptmax;
my $result = ($n == 0) ? 1 : -1;

say $result;
