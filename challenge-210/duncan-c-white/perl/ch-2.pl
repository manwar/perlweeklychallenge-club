#!/usr/bin/perl
#
# Task 2: Number Collision
# 
# You are given an array of integers which can move in right direction if
# it is positive and left direction when negative. If two numbers collide
# then the smaller one will explode. And if both are same then they both
# explode. We take the absolute value in consideration when comparing.
# 
# All numbers move at the same speed, therefore any 2 numbers moving in
# the same direction will never collide.
# 
# Write a script to find out who survives the collision.
# 
# Example 1:
# 
#   Input: @list = (2, 3, -1)
#   Output: (2, 3)
# 
#   The numbers 3 and -1 collide and -1 explodes in the end. So we are
#   left with (2, 3).
# 
# Example 2:
# 
#   Input: @list = (3, 2, -4)
#   Output: (-4)
# 
#   The numbers 2 and -4 collide and 2 explodes in the end. That gives us
#   (3, -4).  Now the numbers 3 and -4 collide and 3 explodes.  Finally we
#   are left with -4.
# 
# Example 3:
# 
#   Input: @list = (1, -1)
#   Output: ()
# 
#   The numbers 1 and -1 both collide and explode. Nothing left in the end.
# 
# MY NOTES: very unclear explanation, but stripped of all the "numbers moving
# left and right" stuff this seems straightforward (I think): find pairs of
# adjacent numbers Pos,Neg where Pos>0 and Neg<0 and remove Pos or Neg depending
# on min(Pos,abs(Neg)).  Then repeat.  I don't know whether one round should
# find all such immediate (Pos,Neg) pairs, as all the examples show only one
# explosion per round.  Or perhaps that doesn't matter, it's just more rounds.
#
# PLEASE NOTE: Getopt::Long has an unfortunate side-effect - -ve numbers are
# parsed as flags, so I've commented out the -d parsing..  If you want debug
# output, edit the setting of $debug below.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl into C
# (look in the C directory for that)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=1;
#die "Usage: collide [--debug] -- intlist\n"
#	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

die "Usage: collide intlist\n" unless @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

#
# my $pos = find_pos_neg( @list );
#	Search in the given @list for a positive number
#	immediately followed by a negative number.
#	If you find such a pair return the position of
#	the positive number.
#	If there is no such pair, return -1.
#
sub find_pos_neg (@)
{
	my( @list ) = @_;
	for( my $i=0; $i<@list-1; $i++ )
	{
		return $i if $list[$i]>=0 && $list[$i+1]<0;
	}
	return -1;
}


for( my $round = 1;  ; $round++ )
{
	my $pos = find_pos_neg( @list );
	say "round $round: list = ", join(',',@list), " pos = $pos" if $debug;
	last if $pos == -1;

	my $a = $list[$pos];
	my $b = $list[$pos+1];
	say "debug: elements $a and $b collide" if $debug;
	my $ma = $a;
	my $mb = abs($b);
	my $rempos = $pos;		# remove which starting position?
	my $nrem = 1;			# how many to remove?
	if( $ma == $mb )		# remove both
	{
		say "debug: both elements $a and $b explode" if $debug;
		$rempos = $pos;
		$nrem = 2;
	} elsif( $ma > $mb )
	{
		say "debug: element $b explodes" if $debug;
		$rempos = $pos+1;
	} else
	{
		say "debug: element $a explodes" if $debug;
	}
	my @removed = splice( @list, $rempos, $nrem, () );
	say "debug: removing $nrem elements starting at pos $rempos: ", join(',',@removed) if $debug;
	say "end of round $round: list = ", join(',',@list) if $debug;
	#die;
}

say join(',',@list);
