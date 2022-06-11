#!/usr/bin/perl
# 
# TASK 1: Circular Prime
# 
# Write a script to find out first 10 circular primes having at least 3
# digits (base 10).
# 
# Please checkout https://en.wikipedia.org/wiki/Circular_prime for more information.
# 
# A circular prime is a prime number with the property that the number
# generated at each intermediate step when cyclically permuting its (base
# 10) digits will also be prime.
# 
# Quote from the Wikipedia page:
# 
# "For example, 1193 is a circular prime, since 1931, 9311 and 3119 all
# are also prime.[3] A circular prime with at least two digits can only
# consist of combinations of the digits 1, 3, 7 or 9, because having 0, 2,
# 4, 6 or 8 as the last digit makes the number divisible by 2, and having
# 0 or 5 as the last digit makes it divisible by 5"
# 
# OUTPUT
# 
# 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933
# 
# MY NOTES: ok, sounds relatively easy.  The wikipedia page clarifies it.
# I'm reusing my old favourite MakePrimes.pm.
#
# HOWEVER, my solution finds far more circular primes than the above output
# shows.  If 113 is a CP (and it is cos 131 and 311 are also prime), then SO
# IS 131 AND SO IS 311, but the above list doesn't show either.  Also, my
# solution computes ALL CPs with exactly N digits (on the assumption that
# there are probably 10 or more), rather than only the first 10 with N or
# more digits.
#
# btw, for checking primeness I use
#  perl -I. -MMakePrimes -E 'say join(",",primes_upto(999))'
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: circular-prime [--debug] [NDIGITS default 3]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;
my $ndigits = shift // 3;

my %isprime;


#
# my $iscp = iscircularprime($prime);
#	Check whether prime $prime is a circular prime, using %isprime.
#	Return 1 iff it is a circular prime, 0 otherwise.
#
sub iscircularprime ($)
{
	my( $prime ) = @_;
	my $len = length($prime);
	print "debug: iscp: checking whether $prime is a cp\n" if $debug;
	foreach my $i (1..$len-1)
	{
		$prime =~ /^(.)(.+)$/;
		my( $firstdigit, $rest ) = ( $1, $2 );
		$prime = $2.$1;
		print "debug: rotate circular gives $prime\n" if $debug;
		return 0 unless $isprime{$prime};
	}
	return 1;
}


my $limit = 10**$ndigits-1;
print "getting primes up to $limit\n" if $debug;
my @primes = primes_upto( $limit );
%isprime = map { $_ => 1 } @primes;

# discard primes not ndigits long, or containing 0,2,4,5, or 8
@primes = grep { length($_) == $ndigits && $_ !~ /[024568]/ } @primes;

# discard non-circular primes
@primes = grep { iscircularprime($_) } @primes;

say join(', ', @primes);
