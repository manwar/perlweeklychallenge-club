#!/usr/bin/env perl
use strict;
use warnings;
use v5.26;

#Find the first 10 sexy primes

my $i=1;
my $count=10;
my @primes;
while ($count) {
	if (isPrime($i)) {
		@primes=grep { $i-$_ <=6} @primes;
		my @match=grep {$i-6 == $_} @primes;
		if (@match) {
			printf "Sexy Pair: %d,%d\n", $match[0], $i;
			$count--;
		}
		push @primes, $i;
	}
	$i++;
}

sub isPrime {
	my $t=shift;
	my $sum=0;
	for (1..(int $t/2)) {
		$sum++ if $t % $_ == 0;
		last if $sum >1;
	}
	$sum==1;
}
