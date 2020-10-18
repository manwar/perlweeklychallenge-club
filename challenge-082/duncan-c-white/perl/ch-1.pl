#!/usr/bin/perl
#
# Task 1: "Common Factors
#
# You are given 2 positive numbers $M and $N.
# 
# Write a script to list all common factors of the given numbers.
# 
# Example 1:
# 
# Input:
#     $M = 12
#     $N = 18
# 
# Output:
#     (1, 2, 3, 6)
# 
# Explanation:
#     Factors of 12: 1, 2, 3, 4, 6
#     Factors of 18: 1, 2, 3, 6, 9
# 
# Example 2:
# 
# Input:
#     $M = 18
#     $N = 23
# 
# Output:
#     (1)
# 
# Explanation:
#     Factors of 18: 1, 2, 3, 6, 9
#     Factors of 23: 1
# 
# My notes: simple, find factors and then intersect.
# 

use strict;
use warnings;
use Function::Parameters;
use feature 'say';
use Data::Dumper;

die "Usage: common-factors a b\n" unless @ARGV==2;
my( $a, $b ) = @ARGV;

#
# my @factor = factors( $n );
#	Find all factors (including 1) of $n, return a sorted
#	array @factor of all the factors.
#
fun factors( $n )
{
	my $limit = int($n/2);
	my @result = grep { $n % $_ == 0 } (1..$limit);
	return @result;
}


my @afactor = factors( $a );
my @bfactor = factors( $b );

my %a = map { $_ => 1 } @afactor;
my @common = grep { $a{$_} } @bfactor;

say '(' . join( ',', @common ) . ')';
