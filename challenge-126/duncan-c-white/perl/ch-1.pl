#!/usr/bin/perl
# 
# Task 1: "Count Numbers
# 
# You are given a positive integer $N.
# 
# Write a script to print count of numbers from 1 to $N that don't
# contain digit 1.
# 
# Example
# 
# Input: $N = 15
# Output: 8
# 
#     There are 8 numbers between 1 and 15 that don't contain digit 1.
#     2, 3, 4, 5, 6, 7, 8, 9.
# 
# Input: $N = 25
# Output: 13
# 
#     There are 13 numbers between 1 and 25 that don't contain digit 1.
#     2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25.
# "
# 
# My notes: very easy.  Let's produce the "There are ..." output if --debug
# is given, the terse output otherwise.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

my $debug=0;
die "Usage: count-numbers-wo-1 [-d|--debug] N\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift;
die "count-numbers-wo-1: N ($n) must be > 0\n" unless $n>0;

#
# my @answers = find_numbers_wo_1( $n );
#	Find all numbers between 1 and $n NOT containing /1/;
#	return the array of such numbers.
#
fun find_numbers_wo_1( $n )
{
	my @x = grep { ! /1/ } 2..$n;
	return @x;
}


my @answers = find_numbers_wo_1( $n );
my $nanswers = @answers;
if( $debug )
{
	say "There are $nanswers numbers between 1 and $n that don't contain 1:";
	say join(', ', @answers );
} else
{
	say $nanswers;
}
