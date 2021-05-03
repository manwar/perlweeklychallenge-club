#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);


my $m = 200;			# max value for prime list
my @primes = buildPrimes($m);
my ( @strongPrime,@weakPrime );

for my $i (1..$#primes-1){
	if ( $primes[$i] > ($primes[$i-1]+$primes[$i+1])/2 ){
		push @strongPrime,$primes[$i];
	}elsif ( $primes[$i] < ($primes[$i-1]+$primes[$i+1])/2 ){
		push @weakPrime,$primes[$i];
	}
}  
print "Strong Primes: @strongPrime[0..9]\n";
print "Weak Primes: @weakPrime[0..9]\n";
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
	@prime = grep{ $prime[$_] } 2..$m;
	return @prime;
}

