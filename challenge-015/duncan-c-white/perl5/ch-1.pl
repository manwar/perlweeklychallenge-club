#!/usr/bin/perl

# Challenge 1: "Write a script to generate first 10 strong and weak prime numbers.
# 
# the nth prime number is represented by p(n).
# 
#   p(1) = 2
#   p(2) = 3
#   p(3) = 5
#   p(4) = 7
#   p(5) = 11
# 
#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2
# "
# 
# My notes:
# 
# Sounds easy enough.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

#
# my @prime = make_primes( $n );
#	calculate all primes up to $n (nb: in this sense,
#	1 is not a prime, so $prime[0] == 2)
#
fun make_primes( $n )
{
	my @isprime;
	for( my $i=1; $i<=$n; $i++ )
	{
		$isprime[$i] = 1;		# initially
	}

	my $upper = int(sqrt($n));
	#print "debug: n=$n, upper=$upper\n";
	for( my $i=2; $i<=$upper; $i++ )
	{
		if( $isprime[$i] )
		{
			#print "debug: crossing out multiples of $i\n";
			for( my $j=$i*$i; $j<=$n; $j+=$i )
			{
				$isprime[$j] = 0;
			}
		}
	}

	my @prime;
	for( my $i=2; $i<=$n; $i++ )
	{
		push @prime, $i if $isprime[$i];
	}
	return @prime;
}



die "Usage: ch-1.pl N\n" unless @ARGV==1;
my $n = shift;

my @prime = make_primes( 200 * $n );	# 200 is a guess:-)

my @strong;
my @weak;
my @neither = (2);

foreach my $i (1..@prime-2)
{
	my $pi = $prime[$i];
	my $pimo = $prime[$i-1];
	my $pipo = $prime[$i+1];
	my $avg = ($pimo + $pipo)/2;
	#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
	if( $pi > $avg && @strong < $n )
	{
		push @strong, $pi;
	}
	#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2
	if( $pi < $avg && @weak < $n )
	{
		push @weak, $pi;
	}
	#   Neither   Prime number p(n) when p(n) == [ p(n-1) + p(n+1) ] / 2
	if( $pi == $avg && @neither < $n )
	{
		push @neither, $pi;
	}
}

print "first $n strong primes: ", join(',',@strong), "\n";
print "first $n weak primes: ", join(',',@weak), "\n";
print "first $n neither strong-nor-weak primes: ", join(',',@neither), "\n";

die "need more strong primes (have ", scalar(@strong), ")\n" if @strong<$n;
die "need more weak primes (have ", scalar(@weak), ")\n" if @weak<$n;
die "need more neither primes (have ", scalar(@neither), ")\n" if @neither<$n;
