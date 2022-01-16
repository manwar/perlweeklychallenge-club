#!/usr/bin/perl
# 
# TASK #1 - Truncatable Prime
#
# Write a script to generate first 20 left-truncatable prime numbers in base 10.
# 
# In number theory, a left-truncatable prime is a prime number which, in a
# given base, contains no 0, and if the leading left digit is successively
# removed, then all resulting numbers are primes.
# 
# Example
# 
#	9137 is one such left-truncatable prime since 9137, 137, 37 and 7 are
#	all prime numbers.
#
# MY NOTES: Very easy, especially (tada) if you happen to have a prime
# enerating module that you've already used several times in these
# challenges..
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

use lib qw(.);
use MakePrimes;


my %isprime;


#
# my $islt = left_truncatable($p);
#	Return 1 iff prime $p is a left truncatable prime.
#
sub left_truncatable
{
	my( $p ) = @_;
	return 0 if $p =~ /0/;
	my $origp = $p;
	while( length($p)>1 )
	{
		$p =~ s/^\d//;
		return 0 unless $isprime{$p};
	}
	#say "$origp is lt";
	return 1;
}


my $debug=0;
die "Usage: first-n-left-truncatable-primes [--debug] [N, default 20]\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV<2;

my $n = shift // 20;

prime_debug( $debug );

my $bandwidth = 10000;
my $upto = $bandwidth;
my @primes = primes_upto( $upto );
#say "last prime up to $upto is $primes[-1]";
map { $isprime{$_} = 1 } @primes;

my @ltprimes = grep { left_truncatable($_) } @primes;
my $ltprimesfound = @ltprimes;

while( $ltprimesfound < $n )
{
	my $from = $upto;
	$upto += $bandwidth;
	my @moreprimes = more_primes( $from, $upto );
	say "checking primes up to $moreprimes[-1], $ltprimesfound left truncatable primes found";
	map { $isprime{$_} = 1 } @moreprimes;
	push @ltprimes, grep { left_truncatable($_) } @moreprimes;
	$ltprimesfound = @ltprimes;
}

say join( ', ', @ltprimes[0..$n-1] );
