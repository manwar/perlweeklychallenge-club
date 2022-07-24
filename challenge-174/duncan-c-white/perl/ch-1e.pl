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
# This version (ch-1e.pl) makes another optimization: turn disarium_inorder()
# into next_disarium() that find the NEXT disarium number, this allows it to
# embed a fast loop inside it, share some of the calculations, plus of course
# the Perl interpreter has to execute millions fewer subroutine calls.
# these minor changes makes it run about twice as fast as ch-1d.pl
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
# my $nextdis = next_disarium( $x );
#	Return the next disarium number >= $x
#
sub next_disarium
{
	my( $x ) = @_;
	state @dsum;	# cache of disarium sum
	state $len = 1;	# length of $x
	state $pten = 10;# next power of 10
	if( $x<10 )
	{
		$dsum[$x] = $x;
		return $x;
	}
	my $sum;
	$x--;
	do
	{
		$x++;
		my $xd10 = int($x/10);
		$sum = $dsum[$xd10] + ($x % 10) ** $len;
		$dsum[$x] = $sum;
		say "debug: dis($x): sum=$sum" if $debug;
		if( $x == $pten )
		{
			$len++;
			$pten *= 10;
		}
	} while( $sum != $x );
	return $x;
}


#my $is = disarium(518);
#die "debug: dis(518) = $is\n";


my @found = (0);
for( my $i = 1; @found < $n; $i++ )
{
	$i = next_disarium($i);
	say "debug: found dis $i" if $debug;
	push @found, $i;
}

say join(',', @found );
