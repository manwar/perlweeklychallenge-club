#!/usr/bin/perl
# 
# TASK #1 - Integer Square Root
#
# You are given a positive integer $N.
# 
# Write a script to calculate the integer square root of the given number.
# 
# Please avoid using a built-in function. Find out more about it:
# 
# https://en.wikipedia.org/wiki/Integer_square_root
# 
# Examples
# 
#   Input: $N = 10
#   Output: 3
# 
#   Input: $N = 27
#   Output: 5
# 
#   Input: $N = 85
#   Output: 9
# 
#   Input: $N = 101
#   Output: 10
# 
# MY NOTES: Pretty easy as the Wikipedia page shows a C implementation
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

#
# my $isqrt = isqrt($n);
#	Return the integer sqrt of $n.
#
sub isqrt
{
	my( $n ) = @_;

	return $n if $n < 2;

	my $x0 = $n >> 1;			# Initial estimate

	my $x1 = ( $x0 + $n / $x0 ) >> 1;	# Update
		
	while ( $x1 < $x0 )			# This also checks for cycle
	{
		$x0 = $x1;
		$x1 = ( $x0 + $n / $x0 ) >> 1;
	}
	
	return $x0;
}


my $debug=0;
die "Usage: int-sqrt N\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift @ARGV;

say isqrt($n);
