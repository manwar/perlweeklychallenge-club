#!/usr/bin/perl
# 
# Task 1: Disarium Numbers
# 
# Write a script to generate first 19 Disarium Numbers.
# 
# A disarium number is an integer where the sum of each digit raised to the power of its position in the number, is equal to the number.
# 
# For example,
# 
# 518 is a disarium number as
#   (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518
# 
# MY NOTES: ok, sounds pretty easy.
# This version (ch-1c.pl) makes a tiny optimization: cache disarium sums,
# as we are checking successively bigger numbers for "disarium-ness".
# This minor change makes it run about 3 TIMES FASTER than the original!
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: first-N-disarium-numbers [--debug] [N default 19]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 19;

my @dsum;	# cache of disarium sum


#
# my $isdis = disarium( $x );
#	Return 1 iff $x is a disarium number; 0 otherwise.
#
sub disarium
{
	my( $x ) = @_;
	my( $xd10, $xm10 ) = ( int($x/10), $x % 10 );
	my $sum = 0;
	if( defined $dsum[$xd10] )
	{
		my $len = length($x);
		$sum = $dsum[$xd10] + $xm10 ** $len;
	} else
	{
		my @dig = split( //, $x );
		for( my $pos=0; $pos < @dig; $pos++ )
		{
			$sum += $dig[$pos] ** ($pos+1);
		}
	}
	$dsum[$x] = $sum;
	say "debug: dis($x): sum=$sum" if $debug;
	return $sum == $x ? 1 : 0;
}


#my $is = disarium(518);
#die "debug: dis(518) = $is\n";


my @found;
for( my $i = 0; @found < $n; $i++ )
{
	# check if $i is a disarium number, if so add it to @found
	next unless disarium($i);
	say "debug: found dis $i" if $debug;
	push @found, $i;
}

say join(',', @found );
