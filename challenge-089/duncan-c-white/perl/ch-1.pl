#!/usr/bin/perl
#
# Task 1: "GCD Sum
# 
# You are given a positive integer $N.
# Write a script to sum GCD of all possible unique pairs between 1 and $N.
# 
# Example 1:
# 
# 	Input: 3
# 	Output: 3
# 
# 	gcd(1,2) + gcd(1,3) + gcd(2,3)
# 
# Example 2:
# 
# 	Input: 4
# 	Output: 7
# 
# 	gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4)
# "
# 
# My notes: very clearly defined.  Haven't used GCDs for a while:-)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

#
# my $gcd = gcd( $a, $b );
#	Compute and return the GCD (Greatest Common Denominator) of $a and $b.
#
sub gcd ($$)
{
	my( $a, $b ) = @_;
	while( $b != 0 )
	{
		( $a, $b ) = ( $b, $a % $b );
	}
	return $a;
}


my $debug = 0;
die "Usage: gcd-sum [--debug] N\n" unless
	GetOptions( "debug" => \$debug ) &&
	@ARGV==1;
my $n = shift;

my $sum = 0;
foreach my $a (1..$n-1)
{
	foreach my $b ($a+1..$n)
	{
		my $gcd = gcd($a,$b);
		say "sum += gcd($a,$b):$gcd" if $debug;
		$sum += $gcd;
	}
}
say $sum;
