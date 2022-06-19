#
# Prime factors:
# 	compute the prime factors of a number, using the old fashioned
#	isprime "try all the factors"
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;


my $debug = 0;


#
# my $isprime = isprime( $n );
#	Return 1 iff $n is a prime.  Return 0 otherwise.
#
sub isprime
{
	my( $n ) = @_;
	my $lim = int(sqrt($n));
	foreach my $div (2..$lim)
	{
		return 0 if $n % $div == 0;
	}
	return 1;
}


#
# my @factors = prime_factors( $n );
#	Break $n>1 apart into it's PRIME FACTORS (excluding 1).
#	Return the list of prime factors, smallest first.
#	eg. prime_factors( 228 ) = 2,2,3,19
#
fun prime_factors( $n )
{
	die "prime_factors: n ($n) must be >1\n" if $n<=1;
	my @result;
	my $lim = $n;
	my $orign = $n;
	foreach my $f (2..$lim)
	{
		next unless isprime($f);
		say "pf($orign): considering prime factor $f" if $debug;
		while( $n>1 && $n % $f == 0 )
		{
			say "pf($orign): n=$n, adding $f to result" if $debug;
			push @result, $f;
			$n /= $f;
			say "pf($orign): n /= $f (so n=$n now)" if $debug;
		}
		last if $n==1;
	}
	say "pf($orign): prime factors are @result" if $debug;
	return @result;
}


1;
