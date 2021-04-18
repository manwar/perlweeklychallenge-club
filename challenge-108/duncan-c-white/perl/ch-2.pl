#!/usr/bin/perl
# 
# Task 2: "Bell Numbers
# 
# Write a script to display top 10 Bell Numbers. Please refer to
# 
# https://en.wikipedia.org/wiki/Bell_number
# 
# for more informations.
# 
# Example:
# 
# B0: 1 as you can only have one partition of zero element set
# 
# B1: 1 as you can only have one partition of one element set {a}.
# 
# B2: 2
# 
#    {a}{b}
#    {a,b}
# 
# B3: 5
# 
#    {a}{b}{c}
#    {a,b}{c}
#    {a}{b,c}
#    {a,c}{b}
#    {a,b,c}
# 
# B4: 15
# 
#    {a}{b}{c}{d}
#    {a,b,c,d}
#    {a,b}{c,d}
#    {a,c}{b,d}
#    {a,d}{b,c}
#    {a,b}{c}{d}
#    {a,c}{b}{d}
#    {a,d}{b}{c}
#    {b,c}{a}{d}
#    {b,d}{a}{c}
#    {c,d}{a}{b}
#    {a}{b,c,d}
#    {b}{a,c,d}
#    {c}{a,b,d}
#    {d}{a,b,c}
# "
# 
# My notes: Bell's triangle has a simple algorithm; let's use that!
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: bells-numbers [--debug] N\n"
	unless GetOptions("debug"=>\$debug) && @ARGV<2;

my $n = shift // 10;

my @bell = first_n_bell_nos( $n );
say join( ',', @bell );

#
# my @bell = first_n_bell_nos( $n );
#	Generate and return the first $n bell numbers.
#
fun first_n_bell_nos( $n )
{
	my @result;
	my @currrow = (1);
	push @result, $currrow[0];
	foreach my $i (1..$n-1)
	{
		my @nextrow;
		$nextrow[0] = $currrow[-1];
		foreach my $j (1..$i)
		{
			$nextrow[$j] = $currrow[$j-1] + $nextrow[$j-1];
		}
		say join( ' ', @nextrow ) if $debug;
		push @result, $nextrow[0];
		@currrow = @nextrow;
	}
	return @result;
}
