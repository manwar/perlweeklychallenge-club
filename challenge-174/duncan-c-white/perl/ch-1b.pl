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
# This version (ch-1b.pl) makes a tiny optimization: precompute the digit
# powers, storing them in an array.  Sadly, this runs no faster than the
# original, I guess '**' must be well optimized in Perl.
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

# precompute the digit powers..

my @dp;	# dp[dig][pow] = dig**pow
foreach my $dig (0..9)
{
	$dp[$dig] = [];
	my $p = $dig;
	foreach my $pow (1..10)
	{
		$dp[$dig][$pow] = $p;
		$p *= $dig;
	}
}
#die Dumper \@dp;


#
# my $isdis = disarium( $x );
#	Return 1 iff $x is a disarium number; 0 otherwise.
#
sub disarium
{
	my( $x ) = @_;
	my @dig = split( //, $x );
	my $sum = 0;
	for( my $pos=0; $pos < @dig; $pos++ )
	{
		$sum += $dp[$dig[$pos]][$pos+1];
	}
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
