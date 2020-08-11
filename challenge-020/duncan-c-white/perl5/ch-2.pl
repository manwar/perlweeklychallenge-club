#!/usr/bin/perl
#
# Challenge 2: "Write a script to print the smallest pair of Amicable Numbers."
# 
# Amicable numbers are two different numbers so related that the sum of the
# proper divisors of each is equal to the other number. (A proper divisor
# of a number is a positive factor of that number other than the number
# itself. For example, the proper divisors of 6 are 1, 2, and 3.)
# 
# The smallest pair of amicable numbers is (220, 284). They are amicable
# because the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
# 55 and 110, of which the sum is 284; and the proper divisors of 284 are 1,
# 2, 4, 71 and 142, of which the sum is 220.
# 
# The first ten amicable pairs are: (220, 284), (1184, 1210), (2620,
# 2924), (5020, 5564), (6232, 6368), (10744, 10856), (12285, 14595),
# (17296, 18416), (63020, 76084), and (66928, 66992)
# 
# My notes: Another clearly described problem.  Obvious method involves
# a bit of caching.
# 

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-2.pl UPPERLIMIT\n" unless @ARGV==1;
my $upper = shift;

my @spd;	# spd[i] == sum of proper divisors of i

#
# my $spd = sum_proper_divisors($n);
#	Generate and return the sum of all the proper divisors of $n,
#	the proper divisors are those integer divisors (factors) of $n
#	INCLUDING 1 and EXCLUDING $n ITSELF.  eg the proper divisors of
#	$n==6 are 1,2 and 3, and their sum is 6.
#
fun sum_proper_divisors( $n )
{
	my $sum = 0;
	for( my $f=1; $f<$n; $f++ )
	{
		next unless $n % $f == 0;
		$sum += $f;
	}
	return $sum;
}



foreach my $p (2..$upper)
{
	$spd[$p] //= sum_proper_divisors($p);
	my $q = $spd[$p];
	next if $q <= $p;
	$spd[$q] //= sum_proper_divisors($q);
	next unless $spd[$q] == $p;
	print "found amicable pair p=$p, q=$q (spd[p]=$spd[$p], spd[q]=$spd[$q])\n";
}
