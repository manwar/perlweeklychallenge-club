#!/usr/bin/perl
#
# Task 1: "Product SubArray
# 
# Given a list of 4 or more numbers, write a script to find the contiguous
# sublist that has the maximum product. The length of the sublist is
# irrelevant; your job is to maximize the product.
# 
# Example
# 
# Input: [ 2, 5, -1, 3 ]
# 
# Output: [ 2, 5 ] which gives maximum product 10.
# "
# 
# My notes: very straightforward.
#

use strict;
use warnings;
use feature 'say';

die "Usage: max-product-array NUMBERS\n" unless @ARGV>3;
my @l = @ARGV;
my $max = $l[0];
my $maxfrom = 0;
my $maxto = 0;

foreach my $i (0..$#l)
{
	my $prod = $l[$i];
	if( $prod > $max )
	{
		$max = $prod;
		$maxfrom = $i;
		$maxto = $i;
	}
	foreach my $j ($i+1..$#l)
	{
		$prod *= $l[$j];
		if( $prod > $max )
		{
			$max = $prod;
			$maxfrom = $i;
			$maxto = $j;
		}
	}
}

say "maximum product is $max, ", join('x',@l[$maxfrom..$maxto]);
