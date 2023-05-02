#!/usr/bin/perl
#
# Task 2: Collect Points
# 
# You are given a list of numbers.
# You will perform a series of removal operations. For each operation,
# you remove from the list N (N >= 1) equal and consecutive numbers,
# and add to your score N x N.
# Determine the maximum possible score.
# 
# Example 1:
# 
#   Input: @numbers = (2,4,3,3,3,4,5,4,2)
#   Output: 23
# 
#   We see three 3's next to each other so let us remove that first and
#   collect 3 x 3 points.
#   So now the list is (2,4,4,5,4,2).
#   Let us now remove 5 so that all 4's can be next to each other and
#   collect 1 x 1 point.
#   So now the list is (2,4,4,4,2).
#   Time to remove three 4's and collect 3 x 3 points.
#   Now the list is (2,2).
#   Finally remove both 2's and collect 2 x 2 points.
#   So the total points collected is 9 + 1 + 9 + 4 => 23.
# 
# Example 2:
# 
#   Input: @numbers = (1,2,2,2,2,1)
#   Output: 20
# 
#   Remove four 2's first and collect 4 x 4 points.
#   Now the list is (1,1).
#   Finally remove the two 1's and collect 2 x 2 points.
#   So the total points collected is 16 + 4 => 20.
# 
# Example 3:
# 
#   Input: @numbers = (1)
#   Output: 1
# 
# Example 4:
# 
#   Input: @numbers = (2,2,2,1,1,2,2,2)
#   Output: 40
# 
#   Remove two 1's = 2 x 2 points.
#   Now the list is (2,2,2,2,2,2).
#   Then remove six 2's = 6 x 6 points.
# 
# MY NOTES: hmmm.. that seems a bit tricky, in particular I can't immediately
# see whether we have do try all possible first moves (etc), or just the first
# move (or nth move more generally) with the greatest score contribution..
# Actually, eg 4 shows that we CAN'T just take the individual move with the
# greatest score contribution, cos otherwise we'd take one of the "length 3"
# sequences and pass up the "length 6" sequence that becomes available later..
# So, yes, it's a brute force "find all" type problem..
# 
# GUEST LANGUAGE: As a bonus, I had a go at translating ch-2.pl into C, a
# few days late: look in the C/ directory for that.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: collect-points [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;


#
# my @moves = all_possible_first_moves( @list );
#	Find all possible first (immediate) moves, return
#	a list of moves where each move is a [ startpos, len ] pair.
#
fun all_possible_first_moves( @list )
{
	my @moves;
	my $startpos;
	my $currval;
	my $pos = 0;
	do
	{
		$currval = $list[$pos];
		my $len = 0;
		for( $startpos=$pos; $pos < @list && $list[$pos]==$currval; $pos++ )
		{
			$len++;
		}
		push @moves, [$startpos,$len];

	} while( $pos < @list );
	return @moves;
}


my $bestsc;
my $bestmoves;


#
# find_all( $currsc, $currmoves, @list );
#	Find all possible sequences of moves removing item-sequences
#	from @list, given that the current score to this point is $currsc,
#	and the current move string to this point is $currmoves, and
#	track the best (highest scoring) move sequence in $bestsc & $bestmoves
#
fun find_all( $currsc, $currmoves, @list )
{
	if( @list == 0 )
	{
		say "debug: found solution, currsc=$currsc, bestsc=$bestsc" if $debug;
		if( $currsc > $bestsc )
		{
			$bestsc = $currsc;
			$bestmoves = $currmoves;
			say "debug:  found new best, bestsc=$bestsc, bestmoves=$bestmoves" if $debug;
		}
		return;
	}

	my @moves = all_possible_first_moves( @list );

	foreach my $move (@moves)
	{
		my( $startpos, $len ) = @$move;
		my $val = $list[$startpos];
		my @newlist = @list;
		splice( @newlist, $startpos, $len );
		my $newmoves = $currmoves;
		$newmoves .= "," if $currmoves;
		$newmoves .= "$val:$startpos/$len";
		say "debug: list=".join(',',@list).
		    ", currmoves=$currmoves, startpos=$startpos".
		    ", len=$len, val=$val, newlist=".join(',',@newlist)
		    	if $debug;
		find_all( $currsc+$len*$len, $newmoves, @newlist );
	}
}


my @list = split( /,/, join(',',@ARGV) );

say "debug: list: ", join(',',@list) if $debug;

$bestsc = 0;
$bestmoves = "";

find_all( 0, '', @list );

#die Dumper(\@moves);

say $bestsc;
say $bestmoves;
