#!/usr/bin/perl
# 
# TASK #2 - Rob The House
# 
# You are planning to rob a row of houses, always starting with the first
# and moving in the same direction. However, you can't rob two adjacent
# houses.
# 
# Write a script to find the highest possible gain that can be achieved.
# 
# Example 1:
# 
#   Input: @valuables = (2, 4, 5);
#   Output: 7
# 
# If we rob house 0 we get 2 and then the only house we can rob is house
# 2 where we have 5.  So the total valuables in this case is (2 + 5) = 7.
# 
# Example 2:
# 
#   Input: @valuables = (4, 2, 3, 6, 5, 3);
#   Output: 13
# 
# The best choice would be to first rob house 0 then rob house 3
# then finally house 5.  This would give us 4 + 6 + 3 =13.
# 
# MY NOTES: Hmm.. some sort of recursive "find all paths" method.
# It always helps to pick the right function purpose and name.
# I think the recursive function we need is: 
# my $maxvaluables = maxrobbery( startpos ), invoked as
# my $max=maxrobbery(0)?
#
# Extra note: if you want to which the house numbers and corresponding
# valuables that make up the maximum robbery, run this with the -d flag.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

my $debug=0;

die "Usage: rob-houses [--debug] house_values\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @valuables = @ARGV;


#
# my( $maxvaluables, @robhouses ) = maxrobbery( $starthouseno, @valuables );
#	Given a list of valuables @valuables, and a starting house number
#	$starthouseno, try all combinations of houses to rob, always robbing
#	house $starthouseno, not robbing house $starthouseno+1 and considering
#	whether or not to rob each subsequent house, and return the
#	( maximum sum of valuables, and list of robbed house numbers that
#	gave the maximum sum of valuables).
#
fun maxrobbery( $starthouseno, @valuables )
{
	my @besth;
	my $besttotal = 0;
	foreach my $hno ($starthouseno+2..$#valuables)
	{
		# find the best partial solution starting by robbing house $hno
		my( $mv2, @rh2 ) = maxrobbery( $hno, @valuables );

		# then find the best of all those partial solutions
		if( $mv2 > $besttotal )
		{
			$besttotal = $mv2;
			@besth = @rh2;
		}
	}
	# then the overall best solution involves adding starthouseno
	# to the best partial solution..
	return ( $valuables[$starthouseno]+$besttotal, $starthouseno, @besth );
}


my( $maxvaluables, @robhouses ) = maxrobbery( 0, @valuables );
say "max valuables is $maxvaluables";
say "got by robbing house numbers ",
	join(', ',
		map { "$robhouses[$_] (value $valuables[$robhouses[$_]])" }
		       0..$#robhouses
	) if $debug;
