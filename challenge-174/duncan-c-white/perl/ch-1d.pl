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
# This version (ch-1d.pl) makes another optimization: turn disarium() into
# disarium_inorder() that MUST be called with each value of $x in order
# which allows various optimizations.
# This minor change makes it run about 20% faster, but is a stepping stone
# to better things to come.
# 

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Getopt::Long;
use Data::Dumper;


my $debug=0;
die "Usage: first-N-disarium-numbers [--debug] [N default 19]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $n = shift // 19;



#
# my $isdis = disarium_inorder( $x );
#	Return 1 iff $x is a disarium number; 0 otherwise.
#	ONLY WORKS IF THIS IS INVOKED FOR EACH VALUE OF $x IN ORDER
#
sub disarium_inorder
{
	my( $x ) = @_;
	state @dsum;	# cache of disarium sum
	state $len = 1;	# length of $x
	state $pten = 10;# next power of 10
	if( $x<10 )
	{
		$dsum[$x] = $x;
		return 1;
	}
	my( $xd10, $xm10 ) = ( int($x/10), $x % 10 );
	my $sum = $dsum[$xd10] + $xm10 ** $len;
	$dsum[$x] = $sum;
	say "debug: dis($x): sum=$sum" if $debug;
	if( $x == $pten )
	{
		$len++;
		$pten *= 10;
	}
	return $sum == $x ? 1 : 0;
}


#my $is = disarium(518);
#die "debug: dis(518) = $is\n";


my @found;
for( my $i = 0; @found < $n; $i++ )
{
	# check if $i is a disarium number, if so add it to @found
	next unless disarium_inorder($i);
	say "debug: found dis $i" if $debug;
	push @found, $i;
}

say join(',', @found );
