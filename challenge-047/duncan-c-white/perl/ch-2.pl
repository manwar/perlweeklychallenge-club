#!/usr/bin/perl
#
# Task #2: "Gapful Numbers
# 
# Write a script to print first 20 Gapful Numbers greater than or equal
# to 100.  See https://oeis.org/A108343 for details.
# In summary, Gapful Numbers are those numbers >= 100 that are divisible
# by the number formed by their first and last digit.  Numbers up to 100
# trivially have this property and are excluded.  eg. 100 is, because 100%10==0
# "
# 
# My notes: cute.  Sounds easy.
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;

#
# gapful( $i );
#	Return 1 iff $i is a gapful number >= 100.
#
fun gapful( $i )
{
	$i =~ /^(\d).*(\d)$/;	# find first and largest digits
	my $div = 10*$1 + $2;
	return $i % $div == 0 ? 1 : 0;
}


die "Usage: ch-2.pl [FirstN]\n" if @ARGV>1;
my $n = shift // 20;

my $found = 0;
for( my $i = 100; $found<$n; $i++ )
{
	next unless gapful( $i );
	say $i;
	$found++;
}
