#!/usr/bin/perl
#
# Challenge 2: "Write a script to print all possible series of 3 positive
# 	      numbers, where in each series at least one of the number is even
# 	      and sum of the three numbers is always 12. For example, 3,4,5."
# 
# My notes: Well defined, looks straightforward by brute forcish search (with
# the third number in the sequence being fixed as 12-first-second of course,
# so only two degrees of freedom).
#

use v5.10;	# for "say"
use strict;
use warnings;
#use Data::Dumper;


foreach my $first (1..10)
{
	foreach my $second (1..11-$first)
	{
		my $third = 12 - $first - $second;
		next if $third<1;
		next if $first%2==1 && $second%2==1 && $third%2==1;
		say "$first-$second-$third";
	}
}
