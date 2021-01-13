#!/usr/bin/perl
#
# Task 1: "Number Combinations
#
# You are given two integers $m and $n. Write a script print all possible
# combinations of $n numbers from the list 1 2 3 ... $m.
# 
# Every combination should be sorted i.e. [2,3] is a valid combination but
# [3,2] is not.
# 
# Example:
# 
# Input: $m = 5, $n = 2
# 
# Output: [ [1,2], [1,3], [1,4], [1,5], [2,3], [2,4], [2,5], [3,4], [3,5], [4,5] ]
# "
# 
# My notes: generally I hate permutation questions, but this looks ok.
# First digit: may be 1..M-N+1  Second digit: firstdigit+1 .. M-(N-1)+1 etc.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: number-combinations M N\n" unless @ARGV==2;
my( $m, $n ) = @ARGV;


#
# my @l = combinations( $lo, $hi, $n, @pre );
#	Find all sorted combinations of $n digits from $lo..$hi
#	prepending @pre to every combination found.
#
fun combinations( $lo, $hi, $n, @pre )	# @pre is a list of numbers
{
	#say "combinations: lo=$lo, hi=$hi, n=$n, x=", join(',',@pre);
	my @l;			# list of lists
	foreach my $i ($lo..$hi-$n+1)
	{
		my @y = @pre;
		push @y, $i;
		#say "i=$i, y=", Dumper \@y;
		push @l, $n==1 ?
			[ @y ] :
			combinations( $i+1, $hi, $n-1, @y );
	}
	return @l;
}


my @l = combinations( 1, $m, $n, () );
say '[ ', join(', ', map { '['. join(',',@$_). ']' } @l ), ' ]';
