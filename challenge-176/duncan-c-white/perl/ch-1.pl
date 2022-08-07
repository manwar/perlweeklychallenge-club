#!/usr/bin/perl
# 
# Task 1: Permuted Multiples
# 
# Write a script to find the smallest positive integer x such that x, 2x,
# 3x, 4x, 5x and 6x are permuted multiples of each other.
# 
# For example, the integers 125874 and 251748 are permutated multiples of
# each other as
# 
# 251784 = 2 x 125874
# 
# and also both have the same digits but in different order.
# 
# Output
# 
#   142857
# 
# MY NOTES: ok, sounds pretty easy.  Compare permutation either by forming
# bags of digits and comparing them, or simply by sorting the digits
# numerically (a signature) and comparing signatures.
# 
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;


#
# my $ispp6 = permuted_perm_6($x);
#	Return true iff $x is a permuted_perm_6 number,
#	i.e. that x, 2x, 3x, 4x, 5x and 6x are permuted multiples
#	of each other.  Return false otherwise.
#
sub permuted_perm_6
{
	my( $x ) = @_;
	my $xsig = join( '', sort { $a <=> $b } split(//,$x) );
	foreach my $mult (2..6)
	{
		my $xmsig = join( '', sort { $a <=> $b } split(//,$x*$mult) );
		return 0 unless $xsig eq $xmsig;
	}
	return 1;
}


my $debug=0;
die "Usage: smallest-permuted-multiple-6-times [--debug]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==0;

my $x;

for( $x = 1; ! permuted_perm_6($x); $x++ )
{
}

say $x;
