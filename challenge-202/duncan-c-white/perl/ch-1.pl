#!/usr/bin/perl
# 
# Task 1: Consecutive Odds
# 
# You are given an array of integers.
# 
# Write a script to print 1 if there are THREE consecutive odds in the
# given array otherwise print 0.
# 
# Example 1
# 
# Input: @array = (1,5,3,6)
# Output: 1
# 
# Example 2
# 
# Input: @array = (2,6,3,5)
# Output: 0
# 
# Example 3
# 
# Input: @array = (1,2,3,4)
# Output: 0
# 
# Example 4
# 
# Input: @array = (2,3,5,7)
# Output: 1
# 
# MY NOTES: very easy.
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
die "Usage: 3-consec-odds [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;

my @list = split( /,/, join(',',@ARGV) );

die "3-consec-odds: need at least 3 ints in list\n" unless @list>2;

=pod

=head2 my $isodd = isodd( $x );

Return 1 iff $x is odd; else 0.

=cut
sub isodd
{
	my( $x ) = @_;
	return $x % 2 == 1 ? 1 : 0;
}


=pod

=head2 my $has3odds = has3odds( @list );

Return 1 iff @list has 3 consecutive odd numbers; else 0.

=cut
sub has3odds
{
	my( @list ) = @_;
	my $n = @list;

	for( my $spos=0; $spos<$n-2; $spos++ )
	{
		next unless isodd( $list[$spos] );
		say "debug: found odd element $list[$spos] at pos $spos"
			if $debug;
		if( isodd( $list[$spos+1] ) && isodd( $list[$spos+2] ) )
		{
			say "debug: found 3 consec odd elements $list[$spos], ".
			    "$list[$spos+1], $list[$spos+2] starting at ".
			    "pos $spos" if $debug;
			return 1;
		}
	}
	return 0;
}

my $has3odds = has3odds( @list );
say $has3odds;
