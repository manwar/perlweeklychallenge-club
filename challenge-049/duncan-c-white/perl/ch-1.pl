#!/usr/bin/perl
#
# Task 1: "Smallest Multiple:
# 
# Write a script to accept a positive number as command line argument and
# print the smallest multiple of the given number consists of digits 0
# and 1.
# 
# For example:
# For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.
# "
# 
# My notes: cute, sounds easy.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

my $tabulate = 0;
my $result = GetOptions( "tabulate" => \$tabulate );
die "Usage: smallestmultiple [--tabulate] [MAX]\n" if $result && @ARGV>1;

my $max = shift // 50;

if( $tabulate )
{
	foreach my $n (1..$max)
	{
		my $x = smallest_binary_multiple( $n );
		my $f = $x/$n;
		say "smallest multiple of $n ($n x $f) consisting of only 1s and 0s: $x";
	}
}
else
{
	my $x = smallest_binary_multiple( $max );
	my $f = $x/$max;
	say "smallest multiple of $max ($max x $f) consisting of only 1s and 0s: $x";
}


#
# my $x = smallest_binary_multiple( $n );
#	Find the smallest multiple of $n whose decimal representations
#	consist only of digits 0 and 1.  Return that smallest multiple.
#
fun smallest_binary_multiple( $n )
{
	my $mult = $n;
	do {
		$mult += $n;
	} while( $mult =~ /[2-9]/ );
	return $mult;
}


