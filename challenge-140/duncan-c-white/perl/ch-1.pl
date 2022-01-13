#!/usr/bin/perl
# 
# TASK #1 - Add Binary
# 
# You are given two decimal-coded binary numbers, $a and $b.
# 
# Write a script to simulate the addition of the given binary numbers.
# 
# Example 1
# 
# 	Input: $a = 11; $b = 1;
# 	Output: 100
# 
# Example 2
# 
# 	Input: $a = 101; $b = 1;
# 	Output: 110
# 
# Example 3
# 
# 	Input: $a = 100; $b = 11;
# 	Output: 111
# 
# MY NOTES: Very easy.  Extract least significant binary digit via $a % 10,
# implement full adder (bit,bit,carryin)->(bit,carryout), recurse and recombine.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;


my $debug=0;
die "Usage: dcb-add x y\n" unless
	GetOptions( "debug"=>\$debug ) && @ARGV==2;
my( $x, $y ) = @ARGV;

die "dcb-add: $x not a decimal coded binary value\n"
	if $x eq '' || $x =~ /[^01]/;

die "dcb-add: $y not a decimal coded binary value\n"
	if $y eq '' || $y =~ /[^01]/;

#
# my $result = dcb_add( $x, $y, $carry );
#	Perform a binary addition of $x and $y, 2 decimal-encoded
#	binary values (i.e. in which every digit is either 0 and 1),
#	and the 0 or 1 $carry, and return the decimal-encoded result.
#
#	I could make this iterative if desired, using a sum-so-far, and
#	a current-power-of-10 to multiply by.
#
fun dcb_add( $x, $y, $carry )
{
	my $lxd = $x % 10;
	my $lyd = $y % 10;
	my $sum = $lxd + $lyd + $carry;
	$carry = int($sum/2);
	$sum %= 2;
	$x = int($x/10);
	$y = int($y/10);
	return $sum if $x == 0 && $y == 0 && $carry == 0;

	my $result = dcb_add( $x, $y, $carry );
	return 10 * $result + $sum;
}


my $result = dcb_add( $x, $y, 0 );
say $result;
