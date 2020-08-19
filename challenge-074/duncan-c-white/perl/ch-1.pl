#!/usr/bin/perl
#
# Task 1: "Majority Element
#
# You are given an array of integers of size $N.
# 
# Write a script to find the majority element. If none found then print -1.
# The majority element in a list is the element, if any, that appears more than
# floor(size_of_list/2) TIMES.
# 
# Example 1
# 
#   Input: @A = (1, 2, 2, 3, 2, 4, 2)
#   Output: 2, as 2 appears 4 times in the list - more than floor(7/2)==3 TIMES.
# 
# Example 2
# 
#   Input: @A = (1, 3, 1, 2, 4, 5)
#   Output: -1 as none of the elements appears more than floor(6/2)==3 TIMES.
# "
# 
# My notes: ok.  Very easy.
#

use strict;
use warnings;
use feature 'say';
#use Function::Parameters;
#use Data::Dumper;

die "Usage: majority-element list_of_values\n" if @ARGV==0;
my @list = @ARGV;

my $len = @list;
my $half = int($len/2);
#say "len=$len, half=$half";

# convert list to bag (frequency hash)
my %freq;
$freq{$_}++ foreach @list;

my $found = 0;
foreach my $k (keys(%freq))
{
	$found = $k if $freq{$k} > $half;
}
if( $found )
{
	say "$found (appears $freq{$found} times, more than $half)";
} else
{
	say "-1";
}
