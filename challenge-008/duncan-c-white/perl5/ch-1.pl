#!/usr/bin/perl

# Challenge 1: "Write a script that computes the first five perfect
# numbers. A perfect number is an integer that is the sum of its positive
# proper divisors (all divisors except itself). Please check Wiki for
# more information.  First 4 are 6, 28, 496 and 8128"


use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl [N|5]]\n" if @ARGV > 1;


#
# my $isprime = is_prime( $x );
#	Return true iff the integer $x is prime.
fun is_prime( $x )
{
	my $limit = int(sqrt($x));
	#print "is_prime($x): limit=$limit\n";
	foreach my $i (2..$limit)
	{
		return 0 if $x % $i == 0;
	}
	return 1;
}




my $limit = shift // 5;

for( my $p=2, my $found=0; $found<$limit; $p++ )
{
	if( is_prime( $p ) )
	{
		my $twop1 = 2**($p-1);
		my $twop = 2*$twop1;
		my $twopminus1 = $twop-1;
		if( is_prime( $twopminus1 ) )
		{
			print "$p is prime and 2^$p-1 ($twopminus1) is prime\n";
			my $perfect = ($twop-1) * $twop1;
			print "  so $perfect (2^$p-1 * 2^(p-1) is perfect\n";
			$found++;
		}
		else
		{
			print "$p is prime but 2^$p-1 ($twopminus1) is not prime\n";
		}
	}
}
