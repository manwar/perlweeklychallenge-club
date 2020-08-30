#!/usr/bin/perl
#
# Task 1: "Coins Sum
#
# You are given a set of coins @C, assuming you have infinite amount of each coin in the set.
# 
# Write a script to find how many ways you make sum $S using the coins from the set @C.
#
# Example:
# 
# Input:
#     @C = (1, 2, 4)
#     $S = 6
# 
# Output: 6
# There are 6 possible ways to make sum 6.
# a) (1, 1, 1, 1, 1, 1)
# b) (1, 1, 1, 1, 2)
# c) (1, 1, 2, 2)
# d) (1, 1, 4)
# e) (2, 2, 2)
# f) (2, 4)
# "
# 
# My notes: ok.  Reasonably easy: bag of coins shows what coins we've used,
# at every stage explore 2 paths: 1). add another instance of each possible coin,
# 2). don't add another instance..
#
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

die "Usage: coin-sum target list_of_coinvalues\n" if @ARGV<2;
my( $s, @list ) = @ARGV;

#
# my @ways = findall( $s, $coins, $used );
#	Find all possible ways of achieving sum $s given @$coins.  %$used
#	is the bag of all coins used so far.  Returns @ways, an array of
#	each complete %$used bag.
#
fun findall( $s, $coins, $used )
{
	my @result;
	foreach my $c (@$coins)
	{
		next if $c > $s;	# coin too big..
		my %u2 = %$used;	# make bag u2: used + 1 more $c
		$u2{$c}++;
		if( $c == $s )
		{
			push @result, \%u2;
		} else
		{
			# 2 possibilities: either include zero or one more $c
			# zero: remove $c from copy of @$coins
			my @c2 = grep { $_ ne $c } @$coins;
			
			push @result, findall( $s, \@c2, $used );

			# one more:
			push @result, findall( $s-$c, $coins, \%u2 );
		}
	}
	return @result;
}

#
# my $csv = h2c( %h );
#	Turn a bag %h into a CSV string of (c1) x n1, (c2) x n2..
#
fun h2c( %h )
{
	my @result;
	foreach my $c (sort keys %h)
	{
		push @result, (($c) x $h{$c});
	}
	return join(',',@result);
}


my @ways = map { h2c(%$_) } findall( $s, \@list, {} );
my @uniqueways;
my %seen;
foreach my $w (sort @ways)
{
	push @uniqueways, $w unless $seen{$w}++;
}
my $n = @uniqueways;
say "There are $n possible ways to make sum $s";
say for @uniqueways;
