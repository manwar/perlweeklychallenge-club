#!/usr/bin/perl
#
# Task 2: Maximum XOR
# 
# You are given an array of integers.
# Write a script to find the highest value obtained by XORing any two
# distinct members of the array.
# 
# Example 1
# 
#   Input: @array = (1,2,3,4,5,6,7)
#   Output: 7
# 
#   The maximum result of 1 xor 6 = 7.
# 
# Example 2
# 
#   Input: @array = (2,4,1,3)
#   Output: 7
# 
#   The maximum result of 4 xor 3 = 7.
# 
# Example 3
# 
#   Input: @array = (10,5,7,12,8)
#   Output: 15
# 
#   The maximum result of 10 xor 5 = 15.
# 
# MY NOTES: also quite easy, try all combinations, pick max of all xors.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation).  Needed to
# pass original sizes into C routine..
#

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: max-xor [--debug] intlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @list = split( /,/, join(',',@ARGV) );

say "list: ", join(',',@list) if $debug;

my $max = -1;
my $maxa = -1;
my $maxb = -1;

foreach my $i (0..$#list-1)
{
	foreach my $j ($i+1..$#list)
	{
		my $a = $list[$i]+0;
		my $b = $list[$j]+0;
		my $xor = $a^$b;
		#say "debug: i=$i, j=$j, a=$a, b=$b, xor=$xor, max=$max" if $debug;
		if( $xor > $max )
		{
			$max = $xor;
			$maxa = $a;
			$maxb = $b;
		}
	}
}

say "$max";

say "The maximum result of $maxa xor $maxb = $max" if $debug;
