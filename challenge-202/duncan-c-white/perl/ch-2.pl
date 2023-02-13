#!/usr/bin/perl
# 
# Task 2: Widest Valley
# 
# Given a profile as a list of altitudes, return the leftmost widest
# valley. A valley is defined as a subarray of the profile consisting
# of two parts: the first part is non-increasing and the second part is
# non-decreasing. Either part can be empty.
# 
# Example 1
# 
# Input: 1, 5, 5, 2, 8
# Output: 5, 5, 2, 8
# 
# Example 2
# 
# Input: 2, 6, 8, 5
# Output: 2, 6, 8
# 
# Example 3
# 
# Input: 9, 8, 13, 13, 2, 2, 15, 17
# Output: 13, 13, 2, 2, 15, 17
# 
# Example 4
# 
# Input: 2, 1, 2, 1, 3
# Output: 2, 1, 2
# 
# Example 5
# 
# Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
# Output: 3, 3, 2, 1, 2, 3, 3
# 
# MY NOTES: also quite easy, once we remove the negative "non-increasing"
# language and realise we mean "find the leftmost longest sequence of one
# or more adjacent numbers where initially the numbers go down (or stay
# the same) and then they go up (or stay the same)."
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: widest-valley [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

my $n = @list;

die "widest-valley: need at least 1 int in list\n" unless $n>0;


=pod

=head2 my $len = find_valley( $spos, @list );

find the leftmost longest sequence of one or more adjacent numbers
where initially the numbers go down (or stay the same) and then they
go up (or stay the same).

=cut
fun find_valley( $spos, @list )
{
	my $n = @list;
	my $curr = $list[$spos];
	my $p = $spos+1;
	for( ; $p<$n && $list[$p] <= $curr; $curr=$list[$p++] )
	{
	}
	for( ; $p<$n && $list[$p] >= $curr; $curr=$list[$p++] )
	{
	}
	my $p1 = $p-1;
	say "debug: found valley from pos $spos to pos $p1" if $debug;
	return $p-$spos;
}


my $maxw = 0;
my $maxw_spos = 0;

for( my $spos=0; $spos<$n; $spos++ )
{
	my $w = find_valley( $spos, @list );
	if( $w > $maxw )
	{
		say "debug: found new widest valley starting at $spos: width $w" if $debug;
		$maxw = $w;
		$maxw_spos = $spos;
	}
}


say join( ', ', @list[$maxw_spos..$maxw_spos+$maxw-1] );
