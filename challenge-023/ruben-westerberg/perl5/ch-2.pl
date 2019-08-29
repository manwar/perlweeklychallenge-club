#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

my $i=0;
my @primes;
my @factors;
my $value=my $number=$ARGV[0];
while (1) {	
	push(@primes, nextPrime()) if $i >= @primes;
	last if $primes[$i]>$value;
	if ($value%$primes[$i]==0) {
		$value/=$primes[$i];
		push @factors, $primes[$i];
		$i=0;
	}
	else {
		$i++;
	}
}
print "Prime decomposition of $number: ",join " ", @factors if @factors >1;
print "No decomposition for $number\n" if @factors ==1; 
sub nextPrime {
	state $t=1;
	while (1) {

		$t++;
		my $sum=0;
		for (1..(int $t/2)) {
			$sum++ if $t % $_ == 0;
			last if $sum >1;
		}
		last if $sum==1;
	}
	$t;
}
