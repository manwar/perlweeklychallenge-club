#!/usr/bin/perl
# 
# Task 1: Max Gap
# 
# You are given a list of integers, @list.
# 
# Write a script to find the total pairs in the sorted list where 2
# consecutive elements has the max gap. If the list contains less then 2
# elements then return 0.
# 
# Example 1
# 
# Input:  @list = (2,5,8,1)
# Output: 2
# 
# Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
# 
# Example 2
# 
# Input: @list = (3)
# Output: 0
# 
# MY NOTES: very easy.  sort, then sequence through the sorted list,
# finding the max gap so far and all pairs with that gap.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: max-gap [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

=pod

=head2 my( $maxgap, @pairs ) = find_max_gap( @list );

Find the maximum gap ($maxgap) between any 2 elements in the sorted list
@list, and all pairs (@pairs, array of "el-el" string pairs) of elements
with that $maxgap.

=cut
sub find_max_gap
{
	my( @list ) = @_;
	my $maxgap = 0;
	my @pairs = ();
	foreach my $i (0..$#list-1)
	{
		my $gap = $list[$i+1] - $list[$i];
		say "$i: $list[$i]..$list[$i+1], gap=$gap" if $debug;
		if( $gap > $maxgap )
		{
			$maxgap = $gap;
			@pairs = ( "$list[$i]-$list[$i+1]" );
		} elsif( $gap == $maxgap )
		{
			push @pairs, "$list[$i]-$list[$i+1]";
		}
	}
	return ( $maxgap, @pairs );
}


my @list = split( /,/, join(',',@ARGV) );

die "max-gaps: need at least 2 ints in list\n" unless @list>1;

@list = sort { $a <=> $b } @list;

my( $maxgap, @pairs ) = find_max_gap( @list );
say "maxgap: $maxgap, #pairs: ". scalar(@pairs). ", pairs: ( ". join( ', ', @pairs ) . ' )' if $debug;
say scalar(@pairs);
