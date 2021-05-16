#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);


my $m = 1000000;			# max value for prime list
my @primes = buildPrimes($m);
my $n = 228;
for my $i (@primes){
	last if $n==1;
	if($i <= sqrt($n)){
		while(not $n % $i ){
			print "$i ";
			$n /= $i;
		}
	}else{
		print "$n ";
		last;
	}

}


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

sub isPrime{			# check primality, not is use
	my $n = shift;
	my $nSq = sqrt $n;
	for my $i (@primes){
		last if $i>$nSq;
		return 0 unless $n % $i;
	}
	return 1;
}
