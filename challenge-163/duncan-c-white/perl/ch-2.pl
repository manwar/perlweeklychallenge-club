#!/usr/bin/perl
# 
# TASK #2 - Summations
# 
# You are given a list of positive numbers, @n.
# 
# Write a script to find out the summations as described below.
# 
# Example 1
# 
# Input: @n = (1, 2, 3, 4, 5)
# Output: 42
# 
#     1 2 3  4  5
#       2 5  9 14
#         5 14 28
#           14 42
#              42
# 
# The nth Row starts with the second element of the (n-1)th row.
# The following element is sum of all elements except first element of previous row.
# You stop once you have just one element in the row.
# 
# Example 2
# 
# Input: @n = (1, 3, 5, 7, 9)
# Output: 70
# 
#     1 3  5  7  9
#       3  8 15 24
#          8 23 47
#            23 70
#               70
# 
# MY NOTES: hmmm.  Terrible explanation, but I think the examples show what
# it means, which is quite easy.  Could do that in different languages too:-)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: summations [--debug] list of numbers\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;
my @v = @ARGV;

my $r = 1;
say "row $r: ". join(' ', @v) if $debug;
while( @v > 1 )
{
	shift @v;
	foreach my $pos (1..$#v)
	{
		$v[$pos] += $v[$pos-1];
	}
	$r++;
	say "row $r: ". join(' ', @v) if $debug;
}
say $v[0];
