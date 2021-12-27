#!/usr/bin/perl
# 
# TASK #2 - Like Numbers
# 
# You are given positive integers, $m and $n.  Write a script to find
# total count of integers created using the digits of $m which is also
# divisible by $n.
# 
# Repeating of digits are not allowed. Order/Sequence of digits can't
# be altered. You are only allowed to use (n-1) digits at the most. For
# example, 432 is not acceptable integer created using the digits of
# 1234 (because the digits are in the wrong order). Also for 1234, you can
# only have integers having no more than three digits.
# 
# Example 1:
# 
# 	Input: $m = 1234, $n = 2
# 	Output: 9
# 
# 	Possible integers created using the digits of 1234 are:
# 	1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.
# 
# 	There are 9 integers divisible by 2 such as:
# 	2, 4, 12, 14, 24, 34, 124, 134 and 234.
# 
# Example 2:
# 
# 	Input: $m = 768, $n = 4
# 	Output: 3
# 
# 	Possible integers created using the digits of 768 are:
# 	7, 6, 8, 76, 78 and 68.
# 
# 	There are 3 integers divisible by 4 such as:
# 	8, 76 and 68.
# 
# 
# MY NOTES: Sounds pretty easy.  However, there's one mistake:
# "You are only allowed to use (n-1) digits at the most"
# is flatly contradicted by the examples.  I assume it meant
# "length(m)-1" which is what the examples show.
# 
# So each digit can either be present or absent - it's another "subsets"
# task.  One wrinkle: the length(m)-1 rule means that (all-present) is
# not a valid combination. Plus of course (all-absent) isn't either.
# 
# Last time we did a "subsets" task was in Challenge 136 Task 2,
# Fibonacci Seqence.  In that, I wrote:
# 
# "How do we sum subsets of values?  Two obvious ways:
# 
# 1. recursive function, iterating over the values: each value is either in the
#    subset or not, try both possibilities.
# 2. binary-counting method, iterate over every combination C from 1 ..
#    2**(number values)-1, then sum up only the elements where the corresponding
#    bit in C is on.
# "
# 
# That time, I wrote a (2) binary-counting method.  So this time round, let's
# try a recursive function instead, just for variety.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;


#
# my @result = recursivefind( $prefix, @l );
#	Given an array of letters @l and a prefix $prefix, find all
#	subsets of @l (with $prefix prepended to it).
#	eg if @l==(2,3), and $prefix="1", return ( 12,13 )
#
fun recursivefind( $prefix, @l )
{
	#say "debug: rf($prefix,".join(', ',@l).")" if $debug;
	return ( $prefix ) if @l==0;
	my $first = shift @l;
	# $first is either present in the subset or not -
	# so try both possibilities
	my @result = recursivefind( $prefix, @l );
	push @result, recursivefind( $prefix.$first, @l );
	return @result;
}


#
# my @result = find_all_subsets( $m );
#	Given a string $m, find all non-empty shorter subsets of $m.
#	eg if $m==123, return ( 12,13,23 )
#
fun find_all_subsets( $m )
{
	my @result = recursivefind( "", split( //, $m ) );
	shift @result;		# remove empty subset
	pop @result;		# remove full subset ($m itself)
	return @result;
}


die "Usage: like-numbers [-d|--debug] M N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $m, $n ) = @ARGV;

die "like-numbers: M ($m) must be > 9\n" if $m<10;
die "like-numbers: N ($n) must be >= 2\n" if $n<2;

my @result = sort { $a <=> $b } find_all_subsets( $m );

say "debug: subsets of $m are ", join(', ',@result) if $debug;
@result = grep { $_ % $n == 0 } @result;
say "debug: divisible by $n are ", join(', ',@result) if $debug;

my $nr = @result;

say "Input: m=$m, n=$n";
say "Output: $nr";
