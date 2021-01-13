#!/usr/bin/perl
#
# Task 2: "Wave Array
#
# Any array N of non-unique, unsorted integers can be arranged into a
# wave-like array such that n1 >= n2 <= n3 >= n4 <= n5 and so on.
# 
# For example, given the array [1, 2, 3, 4], possible wave arrays include
# [2, 1, 4, 3] or [4, 1, 3, 2], since 2 >= 1 <= 4 >= 3 and 4 >= 1 <= 3 >= 2.
# This is not a complete list.
# 
# Write a script to print all possible wave arrays for an integer array
# N of arbitrary length.
# 
# Notes:
# 
# When considering N of any length, note that the first element is
# always greater than or equal to the second, and then the >=, <=, >=
# sequence alternates until the end of the array.
# "
# 
# My notes: sounds cute.  How to get started? possible values of n1 are any
# value in the array APART FROM THE SMALLEST ONE, eg given 1..4, n1=2..4
# Then n2 is any other value of the array <= n1; given n1 and n2 and list of
# unused elements @u, n3 is any element in @u that is >= n2.
# eg given 1..4, and n1=2, n2=1, n3 is 3 or 4.  Some sort of recursion should
# do the trick (initially I thought 2 mutually recursive functions, one to
# extend with a value LESS than or equal, the other to extend with a value
# GREATER than or equal, but then I collapsed that via the parameter $less).
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;


die "Usage: wave-arrays ARRAY\n" if @ARGV==0;
my @list = @ARGV;

# sort so we can exclude the smallest
@list = sort @list;

# foreach n1 in @list apart from the smallest
foreach my $n1pos (1..$#list)
{
	my $n1 = $list[$n1pos];
	my @left = @list;
	# remove $n1 from @left
	splice(@left,$n1pos,1);
	#say "removed $n1 from list, remainder is ", Dumper(\@left);
	findwaves( 1, $n1, $n1, @left );
}


#
# findwaves( $less, $curr, $wavesofar, @left );
#	Given the boolean $less, the current value $curr, the wave-list so far
#	$wavesofar (of the form a-b-..$curr) and the unused elements @left,
#	find all wave arrays by extending $wavesofar with all possible next
#	elements from @left that are (LESS THAN if $less, GREATER THAN if !
#	$less) or equal to $curr.  Print all wave arrays as we find them.
#
fun findwaves( $less, $curr, $wavesofar, @left )
{
	my @possnext = grep
		{ ($less && $_ <= $curr) || (!$less && $_ >= $curr) }
		@left;
	return unless @possnext;
	foreach my $next (@possnext)
	{
		my @stillleft = grep { $_ != $next } @left;
		my $nextwave = $wavesofar."-$next";
		if( @stillleft )
		{
			findwaves( 1-$less, $next, $nextwave, @stillleft );
		}
		else
		{
			say $nextwave;
		}
	}
}
