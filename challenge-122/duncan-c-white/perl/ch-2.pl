#!/usr/bin/perl
# 
# Task 2: "Basketball Points
# 
# You are given a score $S.
# 
# You can win basketball points e.g. 1 point, 2 points and 3 points.
# 
# Write a script to find out the different ways you can score $S.
# 
# Example
# 
# Input: $S = 4
# Output: 1 1 1 1
#         1 1 2
#         1 2 1
#         1 3
#         2 1 1
#         2 2
#         3 1
# 
# Input: $S = 5
# Output: 1 1 1 1 1
#         1 1 1 2
#         1 1 2 1
#         1 1 3
#         1 2 1 1
#         1 2 2
#         1 3 1
#         2 1 1 1
#         2 1 2
#         2 2 1
#         2 3
#         3 1 1
# "
# 
# My notes: Assuming I'm understanding it right, all combinations of
# removing 1, 2 or 3 from N repeatedly.  Easyish (recursive).
# NOTE: surely the $S = 5 example omits one last solution "3 2"?
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: basketball-points N\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==1;
my $n = shift;
die "basketball-points: N ($n) > 0\n" if $n<1;

bp( $n, "" );


#
# bp( $n, $prefix );
#	Print out all basketball-point combinations of $n given
#	a prefix (such as "1 1 2") $prefix.
#
fun bp( $n, $prefix )
{
	if( $n >= 1 )
	{
		say "$prefix $n" if $n == 1;
		bp( $n-1, "$prefix 1" ) if $n > 1;
	}
	if( $n >= 2 )
	{
		say "$prefix $n" if $n == 2;
		bp( $n-2, "$prefix 2" ) if $n > 2;
	}
	if( $n >= 3 )
	{
		say "$prefix $n" if $n == 3;
		bp( $n-3, "$prefix 3" ) if $n > 3;
	}
}
