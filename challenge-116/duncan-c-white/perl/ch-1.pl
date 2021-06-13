#!/usr/bin/perl
# 
# Task 1: "Number Sequence
# 
# You are given a number $N >= 10.
# 
# Write a script to split the given number such that the difference between
# two consecutive numbers is always 1 and it shouldn't have leading 0.
# 
# Print the given number if it impossible to split the number.
# 
# Example
# 
#   Input: $N = 1234
#   Output: 1,2,3,4
# 
#   Input: $N = 91011
#   Output: 9,10,11
# 
#   Input: $N = 10203
#   Output: 10203 as it is impossible to split satisfying the conditions.
# "
# 
# My notes: seems pretty easy.  Only question is the initial number's width - try all possible widths.
# 
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

my $debug = 0;
die "Usage: number-sequence N\n" if @ARGV != 1;
my $n = shift;

my @result = splitn( $n );
say join(',', @result);

#
# my @result = splitn_width_w( $w, $n );
#	Solve the problem for width $w.
#
fun splitn_width_w( $w, $n )
{
	my @x;
	my $next = substr($n,0,$w,'');
	push @x, $next;
	while( length($n) > 0 )
	{
		$next++;
		return () unless $n =~ s/^$next//;
		push @x, $next;
	}
	return @x;
}


#
# my @result = splitn( $n );
#	Solve the problem as stated.
#
fun splitn( $n )
{
	foreach my $w (1..length($n)/2)
	{
		my @result = splitn_width_w( $w, $n );
		return @result if @result;
	}
	return $n;
}
