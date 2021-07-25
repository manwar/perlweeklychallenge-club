#!/usr/bin/perl
# 
# Task 1: "Average of Stream
# 
# You are given a stream of numbers, @N.
# 
# Write a script to print the average of the stream at every point.
# 
# Example
# 
# Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
# Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...
# 
# Average of first number is 10.
# Average of first 2 numbers (10+20)/2 = 15
# Average of first 3 numbers (10+20+30)/3 = 20
# Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.
# "
# 
# My notes: sounds quite simple, just requires a running total.
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

die "Usage: stream-average N1 N2...\n" if @ARGV == 0;
my @n = @ARGV;

my $sum = 0;
my $n = 0;
foreach my $val (@n)
{
	$sum += $val;
	$n++;
	print "," if $n>1;
	print $sum/$n;
}
say "";
