#
# Prime factors:
# 	compute the prime factors of a number.
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

#
# my @factors = prime_factors( $n, @primes );
#	Break $n>1 apart into it's PRIME FACTORS (excluding 1),
#	using @primes as a list of all the prime numbers <= n
#	Return the list of prime factors, smallest first.
#	eg. prime_factors( 228 ) = 2,2,3,19
#
fun prime_factors( $n, @primes )
{
	die "prime_factors: n ($n) must be >1\n" if $n<=1;
	my @result;
	foreach my $p (@primes)
	{
		while( $n>1 && $n % $p == 0 )
		{
			push @result, $p;
			$n /= $p;
		}
		last if $n==1;
	}
	return @result;
}


1;
