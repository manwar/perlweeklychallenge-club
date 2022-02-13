#!/usr/bin/perl
# 
# TASK #1 - Binary Tree Depth
# 
# You are given binary tree.
# 
# Write a script to find the minimum depth.
# 
# The minimum depth is the number of nodes from the root to the nearest
# leaf node (node without any children).
# 
# Example 1:
# 
#   Input: '1 | 2 3 | 4 5'
# 
#                 1
#                / \
#               2   3
#              / \
#             4   5
# 
#   Output: 2
# 
# Example 2:
# 
#   Input: '1 | 2 3 | 4 *  * 5 | * 6'
# 
#                 1
#                / \
#               2   3
#              /     \
#             4       5
#              \
#               6
#   Output: 3
# 
# MY NOTES: well, if I built a binary tree from the input, it would be quite
# simple to find the minimum depth.  But there must be a way to solve the
# problem using only the input syntax.  Something like: split into rows on '|'.
# Each row should have 2 * (rowno-1) elements (starting at row 1).  If a row hasn't
# got that many elements, pad it with '*'s.  Now, find the first non-full row,
# ie. with one or more '*'s.  Take the row a pair of elements at a time. If
# any pair are both '*'s, then the min depth is rowno-1.  Otherwise proceed
# to the next row, and keep going down the rows.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my $debug=0;
die "Usage: min-tree-depth [--debug] 'binary tree in rows with *s for missing entries]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $input = shift;

#
# my $mindepth = mindepth( $treeinput );
#	Given an encoded binary tree, with '|' separating rows, spaces
#	separating elements, and '*' representing missing elements not
#	at the end of a row, find and return the minimum depth of the tree.
#
sub mindepth ($)
{
	my( $treeinput ) = @_;

	my @row = split( /\s*\|\s*/, $treeinput );

	my $expectednel = 1;		# how many elements the row is expected
					# to have: it doubles each time

	foreach my $rowno (1..@row)
	{
		my $row = $row[$rowno-1];
		my @el = split( /\s+/, $row );

		# pad the elements out with '*'s if too few..
		push @el, ( '*' ) x ($expectednel - @el);

		#say "row $rowno has *s: ", Dumper \@el;
		# Consider each pair of elements (a,b):
		while( (my $a, my $b, @el) = @el )
		{
			# If they're BOTH '*' the mindepth is rowno-1
			return $rowno-1 if $a eq '*' && $b eq '*';
		}
		$expectednel *= 2;
	}
	return scalar(@row);
}

my $mindepth = mindepth( $input );
say $mindepth;
