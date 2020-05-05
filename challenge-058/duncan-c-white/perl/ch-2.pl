#!/usr/bin/perl
# 
# Task 2: "Ordered Lineup
#
# Write a script to arrange people in a lineup according to how many
# taller people are in front of each person in line. You are given two
# arrays. @H is a list of unique heights, in any order. @T is a list of
# how many taller people are to be put in front of the corresponding
# person in @H. The output is the final ordering of people's heights,
# or an error if there is no solution.
# 
# Here is a small example:
# 
#     @H = (2, 6, 4, 5, 1, 3) # Heights
#     @T = (1, 0, 2, 0, 1, 2) # Number of taller people wanted in front
# 
# The ordering of both arrays lines up, so H[i] and T[i] refer to the same
# person. For example, there are 2 taller people in front of the person
# with height 4, and there is 1 person in front of the person with height 1.
# 
# here is one possible solution that satisfies @H and @T:
# 
# (5, 1, 2, 6, 3, 4)
# 
# Note that the leftmost element is the 'front' of the array.)
# "
# 
# My notes: an unfamiliar problem, sounds quite interesting.  No algorithm
# immediately comes to mind..  Generate-and-test was my first thought - i.e.
# have a function to test "is-this-combination-a-valid-answer" and invoke it
# for every possible answer.  But the question also suggested that our
# algorithm should be able to work at a scale of 1000 people, and the number
# of combinations of 1000 people is insane (1000!).  so scratch that.
#
# After trying a few examples manually, I realised that the first person in
# the queue must be someone who wants 0 people taller than them in front of
# them, and quickly generalised this into what I think it a valid and efficient
# algorithm.  See function "solve".
#
# Run the program on the example as:
#	./ch-2.pl 2,6,4,5,1,3 1,0,2,0,1,2
# bigger examples can be got (in a simple way) by adding ",MAXH+1" to the
# heights, and ",0" to the taller.  eg
#	./ch-2.pl 2,6,4,5,1,3,7 1,0,2,0,1,2,0
#	./ch-2.pl 2,6,4,5,1,3,7,8 1,0,2,0,1,2,0,0
#	...
#	./ch-2.pl 2,6,4,5,1,3,7,8,9,10,11,12,13,14,15,16,17,18 1,0,2,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;


die "Usage: ordered-lineup heights nfronttaller\n" unless @ARGV==2;
my( $heightstr, $nfronttallerstr ) = @ARGV;

my @h = split(/,/,$heightstr);
my @t = split(/,/,$nfronttallerstr);

my $npeople = @h;
my $nt = @t;

die "ordered-lineup: $npeople heights, $nt nfronttallers\n" unless
	$npeople == $nt;

my $nfound = 0;


#
# my $ng = ngreater( $x, @v );
#	Determine the number of values in @v that are greater than $x.
#	Return that number.
#
fun ngreater( $x, @v )
{
	my $ng = grep { $_ > $x } @v;
	#say "there are $ng elements in ", join(',',@v), " bigger than $x";
	return $ng;
}


#
# solve( $hl, $pl );
#	Solve the ordered-lineup problem, given that some
#	progress has already been made: we know the front scalar(@$hl)
#	people of the lineup: they have people numbers @$pl and
#	heights @$hl.  Find all possible one-step extensions of this
#	partial solution that are consistent with the rules, and
#	recurse until you find all solutions.  Set global $nfound to
#	the number of solutions found; uses globals @h and @t for
#	the data.
#
fun solve( $hl, $pl )
{
	my %used = map { $_ => 1 } @$pl;

	#say "solving hl ", join(',',@$hl); # , " and pl ", join(',',@$pl);

	my @possp =
		grep { ! $used{$_} && ngreater( $h[$_], @$hl ) == $t[$_] }
		0..$npeople-1;
	unless( @possp )
	{
		#say "  no possible next people";
		return;
	}
	#say "  possible next heights are ", join(',',map { $h[$_] } @possp);

	foreach my $p (@possp)
	{
		# found unused person p, height h[p] > t[p]
		# elements in $hl.  Add it to copies of hl and pl
		#say "trying unused person $p, height $h[$p] as next";

		my @p2 = @$pl;
		push @p2, $p;
		my @h2 = @$hl;
		push @h2, $h[$p];
		if( @p2 == $npeople )
		{
			say "found solution ", join(',',@h2);
			$nfound++;
		} else
		{
			solve( \@h2, \@p2 );
		}
	}
}


$nfound = 0;

solve( [], [] );
