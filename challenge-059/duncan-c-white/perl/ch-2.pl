#!/usr/bin/perl
# 
# Task 2: "Bit Sum
#
# For this task, you will most likely need a function f(a,b) which returns
# the count of different bits of binary representation of a and b.
# 
# For example, f(1,3) = 1, since:
# 
# Binary representation of 1 = 01
# Binary representation of 3 = 11
# 
# There is only 1 different bit. Therefore the subroutine should return
# 1. Note that if one number is longer than the other in binary, the most
# significant bits of the smaller number are padded (i.e., they are assumed
# to be zeroes).
# 
# Script Output
# 
# Your script should accept n positive numbers. Your script should sum
# the result of f(a,b) for every pair of numbers given:
# 
# For example, given 2, 3, 4, the output would be 6, since f(2,3) + f(2,4)
# + f(3,4) = 1 + 2 + 3 = 6
# "
# 
# My notes: sounds very straightforward.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;


die "Usage: sum-bit-diff n n+\n" if @ARGV<2;
my( @n ) = @ARGV;


#
# my $nbitsdiff = diffbits( $a, $b );
#	Compute and return the numbers of bits of $a and $b
#	that are different.
#
fun diffbits( $a, $b )
{
	my $n = 0;
	while( $a > 0 || $b > 0 )
	{
		$n++ if ($a&1)!=($b&1);
		$a >>= 1;
		$b >>= 1;
	}
	return $n;
}


#my $nbitsdiff = diffbits( 3, 4 );
#say "diffbits(3,4)=$nbitsdiff";

my $sum = 0;
foreach my $i (0..$#n-1)
{
	my $x = $n[$i];
	foreach my $j ($i+1..$#n)
	{
		my $y = $n[$j];
		my $b = diffbits( $x, $y );
		#say "debug: x=$x, y=$y, b=$b";
		$sum += $b;
	}
}
say "at end: sum=$sum";
