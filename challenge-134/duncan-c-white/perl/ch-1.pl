#!/usr/bin/perl
# 
# TASK #1 - Pandigital Numbers
#
# Write a script to generate first 5 Pandigital Numbers in base 10.
#
# As per the wikipedia, it says:
# 
# A pandigital number is an integer that in a given base has among its
# significant digits each digit used in the base at least once.
# The smallest base 10 pandigital number is 1023456789, and subsequent
# ones are lexicographic permutations, ie. 1023456798, 1023456879...
# 
# MY NOTES: Basically just needs a standard lexicographic permutation algorithm,
# with the initial value to permute being 1023456789.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

#
# my $next = next_perm( $val );
#	Find and return the next permutation in lexicographic order
#	of $val.  Return undef is $val is the last permutation (in order).
#	Algorithm treats $val as an array of digits a[n]:
#	1. Find the largest index k such that a[k] < a[k + 1]. If no such index exists,
#	   the permutation is the last permutation.
#       2. Find the largest index l greater than k such that a[k] < a[l].
#       3. Swap the value of a[k] with that of a[l].
#       4. Reverse the sequence from a[k + 1] up to and including the final element a[n].
#
fun next_perm( $val )
{
	my @a = split( //, $val );
	my( $k, $l );
	my $n = @a-1;
	for( $k=$n-1; $k>=0 && $a[$k]>=$a[$k+1]; $k-- )
	{
	}
	return undef if $k<0;
	for( $l=$n; $l>$k && $a[$k]>=$a[$l]; $l-- )
	{
	}
	( $a[$k], $a[$l] ) = ( $a[$l], $a[$k] );

	# reverse a[k+1]..a[n]
	@a[$k+1..$n] = reverse @a[$k+1..$n];

	return join( '', @a );
}


my $debug=0;
die "Usage: first-N-base-10-pandigital-numbers [N, default 5]\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $firstn = @ARGV == 1 ? shift @ARGV : 5;

my $pandigital = "1023456789";

for( my $i=1; $i<=$firstn; $i++ )
{
	die "fallen off last perm\n" unless defined $pandigital;
	say $pandigital;
	$pandigital = next_perm( $pandigital );
}
