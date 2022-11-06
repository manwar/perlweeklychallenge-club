#!/usr/bin/perl
# 
# Task 2: Array Degree
# 
# You are given an array of 2 or more non-negative integers.
# 
# Write a script to find out the smallest slice, i.e. contiguous subarray
# of the original array, having the degree of the given array.
# 
# The degree of an array is the maximum frequency of an element in the array.
# 
# Example 1
# 
# 	Input: @array = (1, 3, 3, 2)
# 	Output: (3, 3)
# 
# 	The degree of the given array is 2.
# 	The possible subarrays having the degree 2 are as below:
# 	(3, 3)
# 	(1, 3, 3)
# 	(3, 3, 2)
# 	(1, 3, 3, 2)
# 
# 	And the smallest of all is (3, 3).
# 
# Example 2
# 
# 	Input: @array = (1, 2, 1, 3)
# 	Output: (1, 2, 1)
# 
# Example 3
# 
# 	Input: @array = (1, 3, 2, 1, 2)
# 	Output: (2, 1, 2)
# 
# Example 4
# 
# 	Input: @array = (1, 1, 2, 3, 2)
# 	Output: (1, 1)
# 
# Example 5
# 
# 	Input: @array = (2, 1, 2, 1, 1)
# 	Output: (1, 2, 1, 1)
# 
# MY NOTES: Ok, sounds pretty easy.  Finding the degree of an array range
# involves building a frequency hash, the degree is max( values %freq ).
# Finding the smallest subarray is easier enough, although tedious.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C and Pascal (look in the obvious directories for the translations).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use List::Util qw(max);
use Data::Dumper;


my $debug=0;
die "Usage: array-degree [--debug] csvlist(int)\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>1;

my @list = @ARGV;
@list = split( /\s*,\s*/, join(',',@list) );
say "debug: list=", join(',',@list) if $debug;


=pod

=head2 my $deg = degree( $arreyref, $from, $to );

Calculate the degree (max frequency) of arrayref->[from..to].

=cut
sub degree ($$$)
{
	my( $arrayref, $from, $to ) = @_;
	my %freq;
	foreach my $i ($from..$to)
	{
		$freq{$arrayref->[$i]}++;
	}
	return max( values(%freq) );
}


my $wholedeg = degree( \@list, 0, $#list );
say "debug: wholedeg=$wholedeg" if $debug;

my $smallestarraysize = $#list+2;
my @smallarray = ();

foreach my $from (0..$#list-1)
{
	foreach my $to ($from+1..$#list)
	{
		my $deg = degree( \@list, $from, $to );
		next unless $deg == $wholedeg;
		my $slicestr = join(',', @list[$from..$to]);
		say "debug: found sub-array $slicestr with degree $deg"
			if $debug;
		my $size = $to+1-$from;
		if( $size < $smallestarraysize )
		{
			$smallestarraysize = $size;
			@smallarray = @list[$from..$to];
		}
	}
}
say join(',',@smallarray);
