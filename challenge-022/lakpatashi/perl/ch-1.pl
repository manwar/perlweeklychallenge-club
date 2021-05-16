#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);
use feature qw(switch);

my $m = 1000;			# max value for prime list
my @primes = buildPrimes($m);

my ($first,$second,$count) = (0,1,0);
for $first (0..$#primes-1){
	#print "$first ";
	my $diff = $primes[$second] - $primes[$first];
	last if $second == $#primes or $count==6;
	#print "$primes[$first]  $primes[$second] :: ";
	
	given($diff){
		when(6){
			print "$primes[$first]  $primes[$second]\n";
			#print "ok\n";
			$first++;
			$second++;
			$count++;
		}
		when($diff<6){
			$second++;
		}
		default{
			$first++;
		}
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

sub isPrime{			# check primality
	my $n = shift;
	my $nSq = sqrt $n;
	for my $i (@primes){
		last if $i>$nSq;
		return 0 unless $n % $i;
	}
	return 1;
}
