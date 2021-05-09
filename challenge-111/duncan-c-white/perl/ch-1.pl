#!/usr/bin/perl
# 
# Task 1: "Search Matrix
#
# You are given 5x5 matrix filled with integers such that each row is
# sorted from left to right and the first integer of each row is greater
# than the last integer of the previous row.
# 
# Write a script to find a given integer in the matrix using an efficient search algorithm.
# 
# Example
# 
#     Matrix: [  1,  2,  3,  5,  7 ]
#             [  9, 11, 15, 19, 20 ]
#             [ 23, 24, 25, 29, 31 ]
#             [ 32, 33, 39, 40, 42 ]
#             [ 45, 47, 48, 49, 50 ]
# 
#     Input: 35
#     Output: 0 since it is missing in the matrix
# 
#     Input: 39
#     Output: 1 as it exists in the matrix
# "
# 
# My notes: could flatten onto a 1D array and binary search.  Other
# methods?  Find which row it's in (if any) and then grep?  Did that.
# Not a very nice method (not even sure it works:-))
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

my @m = (
	[ 1,  2,  3,  5,  7 ],
	[  9, 11, 15, 19, 20 ],
	[ 23, 24, 25, 29, 31 ],
	[ 32, 33, 39, 40, 42 ],
	[ 45, 47, 48, 49, 50 ],
);

#
# my $found = search( $n, @m );
#	Ok, search for $n in 2-D array @m.
#	Return 1 if found, 0 otherwise.
#
fun search( $n, @m )
{
	return 0 if $n < $m[0][0];
	return 0 if $n > $m[4][4];

	# find row
	my $rowno;
	for( $rowno = 0; $rowno<5; $rowno++ )
	{
		last if $m[$rowno][0] <= $n && $m[$rowno][4] >= $n;
	}

	# in row rowno, just grep
	my $found = grep { $_ == $n } @{$m[$rowno]};
	return $found ? 1 : 0;
}



die "Usage: matrix-search N\n" unless @ARGV==1;
my $n = shift;

my $found = search( $n, @m );
say ($found ? $n : 0);
