#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);


my $m = 1000000;			# max value for prime list
my @primes = buildPrimes($m);

my $product = 1 ;
my $status = 0;
for my $x (@primes){
	$product *= $x;
	#print "iter $x :: $product\n";
	#print "$product\n";
	unless(isPrime($product+1)){
		print "found :: ",$product+1,"\n";
		$status =1;
		last;
	}
}
print "Not found" unless($status);

sub buildPrimes{	# building prime list
	my $m=shift;
	my @prime = (1)x($m+1);
	@prime[0,1]=(0)x2;
	for (my $p=2; $p*$p <= $m; $p++){
		if($prime[$p]==1){
			for(my $i= $p*$p; $i<= $m; $i+=$p){
				$prime[$i]=0;
			}
		}
	}
	@prime = grep{ $prime[$_] } 2..100;
	return @prime;
}

sub isPrime{			# check primality
	my $n = shift;
	my $nSq = sqrt $n;
	for my $i (@primes){
		last if $i>$nSq;
		return 0 unless $n % $i;
	}
	return 1;
}
