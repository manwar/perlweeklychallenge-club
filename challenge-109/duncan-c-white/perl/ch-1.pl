#!/usr/bin/perl
# 
# Task 1: "Chowla Numbers
# 
# Write a script to generate first 20 Chowla Numbers, named after,
# Sarvadaman D. S. Chowla, a London born Indian American mathematician. It
# is defined as:
# 
# C(n) = sum of divisors of n except 1 and n
# 
# NOTE: Updated the above definition as suggested by Abigail [2021/04/19 18:40].
# 
# Output:
# 
# 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21
# "
# 
# My notes: easy and fun.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;


#
# my $x = chowla($n);
#	Compute and return the $n'th Chowla number:
#	the sum of the divisors of $n except 1 and $n.
#
fun chowla( $n )
{
	my $sum = 0;
	foreach my $div (2..$n-1)
	{
		$sum += $div if $n%$div==0;
	}
	return $sum;
}


die "Usage: chowla N\n" unless @ARGV==1;
my $n = shift;

foreach my $i (1..$n)
{
	my $x = chowla($i);
	say "c($i) = $x";
}

