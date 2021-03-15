#!/usr/bin/perl
# 
# Task 2: "Binary Substrings
# 
# You are given a binary string $B and an integer $S.
# 
# Write a script to split the binary string $B of size $S and then find
# the minimum number of flips required to make it all the same.
# 
# Example 1:
# 
# 	Input: $B = "101100101" $S = 3
# 	Output: 1
# 
# 	Binary Substrings:
# 	    "101": 0 flip
# 	    "100": 1 flip to make it "101"
# 	    "101": 0 flip
# 
# Example 2:
# 
# 	Input $B = "10110111" $S = 4
# 	Output: 2
# 
# 	Binary Substrings:
# 	    "1011": 0 flip
# 	    "0111": 2 flips to make it "1011"
# "
# 
# My notes:  hmm.. this could be specified a LOT more clearly.  bad phrasing!
# and the examples don't completely clarify what we're supposed to do.
# The first task is obvious: split BS into "length S" chunks - that's trivial..
#
# but then what we do with the chunks is not quite clear - both examples seem
# to show taking the first chunk as the "goal to reach" and then all we
# do is to find out the maximum number of bits that have to be flipped to turn
# any of the OTHER chunks into the goal-chunk.  But what's special about the
# first chunk?  Also, if we do that, where does the word "minimum" come in?
#
# I wonder whether it means, instead:
# - try each distinct chunk as the goal chunk, for each such goal, find the
#   maximum number of bits that have to be flipped to turn chunkN into the
#   goalchunk, AND THEN FIND THE MINIMUM OF ALL THOSE MAXIMUMS.
#
# I'm going to assume that it's the latter..  Update: having coded it, yes,
# this can produce different answers than "first chunk is the goal".
#
# The following example demonstrates the difference:
#
# Example dcw-1:
# 	Input: $B = "000101011111" $S = 3
# 	Output: 2
# 
# 	Binary Substrings:
#	000
#	101
#	011
#	111
#
#  If 000 is the goal, then we'd work out how many bits have to be
#  flipped in each of the other substrings to reach 000, getting:
# 	Binary Substrings:
#	000: 0 flips to teach 000
#	101: 2 flips to teach 000
#	011: 2 flips to teach 000
#	111: 3 flips to teach 000
#  max those is 3.
#
#  But if 101 is the goal, we'd have:
# 	Binary Substrings:
#	000: 2 flips to teach 101
#	101: 0 flips to teach 101
#	011: 2 flips to teach 101
#	111: 1 flip to teach 101
#  let's abbreviate that as: goal: 101: flips=2,0,2,1
#  max those is 2.
#
#  If 011 is the goal, we get flips=2,2,0,1, max 2.
#
#  Finally, if 111 is the goal, we get flips=3,1,1,0, max 3
#
#  So the MINIMUM of all those maximums is: min(3,2,2,3) = 2.
#  That's the answer!
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(min max);

my $debug=0;
die "Usage: binary-strings [--debug] BS S\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==2;
my( $bs, $s ) = @ARGV;

die "binary-strings: BS must be a binary string, not $bs\n"
	unless $bs =~ /^[01]+$/;
die "binary-strings: S must be a +ve int, not $s\n"
	unless $s > 0;
die "binary-strings: len(BS=$bs) must be a multiple of S $s\n"
	unless length($bs) % $s == 0;

# first, split $bs into $s-letter chunks
my @chunk;
while( $bs =~ s/^([01]{$s})// )
{
	push @chunk, $1;
}
if( $debug )
{
	say "Binary Substrings";
	say $_ for @chunk;
}

my $min = solve_problem( @chunk );

say "Input: ", join(',',@chunk);
say "Output: $min";


#
# my $min = solve_problem( @chunk );
#	Solve the problem as described above, loosely
#	min( foreach chunk value goal:
#	       max(flips(goal,chunk) foreach chunk) )
#
fun solve_problem( @chunk )
{
	# find all distinct chunk values:
	my %freq;
	map { $freq{$_}++ } @chunk;
	my @distinct = sort keys %freq;

	# now, try each distinct chunk value in turn as the GOAL
	my @maxflips;
	foreach my $goal (@distinct)
	{
		# find @flips: nflips(goal,chunk) forall chunks
		my @flips = map { nflips( $goal, $_ ) } @chunk;
		print "#flips of all chunks to goal $goal are: ",
			join(',',@flips) if $debug;
		# add max( flips ) to @maxflips
		my $maxflips = max @flips;
		say ", max $maxflips" if $debug;
		push @maxflips, $maxflips;
	}

	say "maximum #flips for all goal chunks are: ",
		join(',',@maxflips) if $debug;

	# now calculate min( @maxflips)
	my $min = min(@maxflips);
	say "minimum maximum #flips = $min" if $debug;

	return $min;
}

#
# my $n = nflips( $a, $b );
#	Given two binary strings $a and $b of the same length,
#	determine how many bits of $a are different from the
#	corresponding bit in $b.  Return the number of different bits.
#
fun nflips( $a, $b )
{
	my $l = length($a);
	die "nflips: len($a) != len($b)\n" unless $l == length($b);
	my $n = 0;
	foreach my $i (0..$l-1)
	{
		$n++ if substr($a,$i,1) ne substr($b,$i,1);
	}
	return $n;
}


