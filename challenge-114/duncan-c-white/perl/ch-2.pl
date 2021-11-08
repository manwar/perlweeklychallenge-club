#!/usr/bin/perl
# 
# Task 2: "Higher Integer Set Bits
# 
# You are given a positive integer $N.
# 
# Write a script to find the next higher integer having the same number
# of 1 bits in binary representation as $N.
# 
# Example
# 
# Input: $N = 3
# Output: 5
# 
# Binary representation of 3 is 011. There are two 1 bits. So the next
# higher integer is 5 having the same the number of 1 bits i.e. 101.
# 
# Input: $N = 12
# Output: 17
# 
# Binary representation of 12 is 1100. There are two 1 bits. So the next
# higher integer is 17 having the same number of 1 bits i.e. 10001.
# "
# 
# My notes: also sounds pretty simple.  Generate and test for "having B
# bits set in the binary representation of numbers > N, where B==nbits(N)".
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

#
# my $nbits = nbits( $n );
#	Count up and return the number of 1 bits in the binary representation of $n.
#
fun nbits( $n )
{
	my $result = 0;
	while( $n > 0 )
	{
		$result++ if $n%2==1;
		$n >>= 1;
	}
	return $result;
}


die "Usage: next-same-no-1-bits N\n" unless @ARGV==1;
my $n = shift;

my $nbits = nbits( $n );

my $i=$n;
do {
	$i++;
} while( nbits($i) != $nbits );

say "Input: \$N = $n";
say "Output: $i";

printf "\nBinary representation of $n is %b. There are %d 1 bits. So the next\n",
	$n, $nbits;
printf "higher integer is $i having the same number of 1 bits, i.e. %b\n", $i;
