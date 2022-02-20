#!/usr/bin/perl
# 
# TASK #1 - Triangle Sum Path
# 
# You are given a triangle array.
# 
# Write a script to find the minimum sum path from top to bottom.
# 
# Example 1:
# 
# 	Input: $triangle = [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ]
# 
# 			1
# 		       5 3
# 		      2 3 4
# 		     7 1 0 2
# 		    6 4 5 2 8
# 
# 	Output: 8
# 
# 	    Minimum Sum Path = 1 + 3 + 2 + 0 + 2 => 8
# 
# Example 2:
# 
# 	Input: $triangle = [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ]
# 
# 			5
# 		       2 3
# 		      4 1 5
# 		     0 1 2 3
# 		    7 2 4 1 9
# 
# 	Output: 9
# 
# 	    Minimum Sum Path = 5 + 2 + 1 + 0 + 1 => 9
# 
# MY NOTES: So it appears at each row, we simply pick the minimum value.
# It doesn't have to be adjacent, or even close to, the one we picked
# on the row above.  Ok, so that's easy!  Actually, parsing the input
# may be the hardest part.  Let's choose a simplified input format:
# each argument is a separate row, and a row looks like '7,2,4,1,9'
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(min);
#use Data::Dumper;

my $debug=0;
die "Usage: triangle-sum-path [--debug] 'triangle row 1' ['triangle row 2...'\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

#
# my $sum = sum_minimum( @rowstr );
#	Given an array of row strings, with elements in one row being
#	comma separated numbers, pick the minimum of each row and sum
#	them, returning the total.
#
sub sum_minimum
{
	my( @rowstr ) = @_;
	my $result = 0;
	foreach my $row (@rowstr)
	{
		my @row = split(/,/, $row);
		$result += min( @row );
	}
	return $result;
}


my $sum = sum_minimum( @ARGV );
say $sum;
