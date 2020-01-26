#!/usr/bin/perl
#
# Task #2: "Make it $200
# 
# You have only $1 left at the start of the week. You have been given an
# opportunity to make it $200. The rule is simple with every move you can
# either double what you have or add another $1. Write a script to help
# you get $200 with the smallest number of moves.
# "
# 
# My notes: doubling sounds like the way to go..  exhaustive breadth first
# search "try both options at every move" seems obvious but combinatorial
# growth could be a problem again. Is there a clever way?
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;


die "Usage: ch-2.pl [GOAL]\n" if @ARGV>1;

my $goal = shift // 200;
my $seq = search( 1, $goal );
say "$goal can be achieved by shortest sequence $seq";

my $curr = 1;
say "start with $curr, goal: $goal";
foreach my $op (split(//,$seq))
{
	if( $op eq "i" )
	{
		$curr++;
		say "increment curr to $curr";
	} else
	{
		$curr *= 2;
		say "double curr to $curr";
	}
}
say "result: $curr, goal: $goal";


#
# my $shortseq = search( $initial, $goal );
#	Given that you have $initial dollars, and you want $goal dollars,
#	perform a breadth-first search to find the $goal in the smallest
#	number of increment or doubling steps.  Return the shortest sequence
#	or 'i' (increment) or 'd' (double) steps that result in $goal dollars.
#
#	Do this using a todo list of ( $dollars, $sequence ) pairs.
#
fun search( $initial, $goal )
{
	my $seq = "";
	my @todo = ( [$initial, ""] );
	for(;;)
	{
		# Build a new list of todo pairs, twice as long as the old one.
		# stopping if we hit $goal
		my @newtodo;
		foreach my $pair (@todo)
		{
			my( $currvalue, $currseq ) = @$pair;
	return $currseq if $currvalue == $goal;

			# try doubling $currvalue
			push @newtodo, [ 2 * $currvalue, $currseq."d" ];

			# try incrementing $currvalue
			push @newtodo, [ $currvalue + 1, $currseq."i" ];
		}
		@todo = @newtodo;
	}
}


