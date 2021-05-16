#!/usr/bin/perl
# 
# Task 2: "Climb Stairs
# 
# You are given $n steps to climb
# 
# Write a script to find out the distinct ways to climb to the top. You
# are allowed to climb either 1 or 2 steps at a time.
# 
# Example
# 
# Input: $n = 3
# Output: 3
# 
#     Option 1: 1 step + 1 step + 1 step
#     Option 2: 1 step + 2 steps
#     Option 3: 2 steps + 1 step
# 
# Input: $n = 4
# Output: 5
# 
#     Option 1: 1 step + 1 step + 1 step + 1 step
#     Option 2: 1 step + 1 step + 2 steps
#     Option 3: 2 steps + 1 step + 1 step
#     Option 4: 1 step + 2 steps + 1 step
#     Option 5: 2 steps + 2 steps
# "
# 
# My notes: looks pretty straightforward, although may not generate the options
# in the same order.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Text::CSV;
#use Data::Dumper;

#
# my @ways = climb( $n );
#	Find and return all ways [each any array of 1|2] of climbing $n
#	stairs, given that we can only climb 1 or 2 stairs per go.
#
fun climb( $n )
{
	if( $n==1 )
	{
		return ( [1] );
	}
	if( $n==2 )
	{
		return ( [1,1], [2] );
	}
	my @ways;
	foreach my $try (1..2)
	{
		my $left = $n-$try;
		my @w = map { [ @$_, $try ] } climb( $left );
		push @ways, @w;
	}
	return @ways;
}



die "Usage: climb-stairs N\n" unless @ARGV==1;
my $n = shift;

my $x = my @ways = climb( $n );
say "Input: $n";
say "Output: $x";
say "";
my $opt = 1;
foreach my $way (@ways)
{
	say "  Option $opt: ", join( ' + ', map { "$_ step".($_==1?"":"s") } @$way );
	$opt++;
}
