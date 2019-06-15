#!/usr/bin/env perl

use strict;
use warnings;
my $searchFlag=1;
my @primes;
my $i=2;
while ($searchFlag) {
	if (isPrime($i)) {
		push @primes, $i;
		my $pp=1;
		for (@primes) {
			$pp*=$_;
		}
		if( !isPrime($pp+1) ) {
			print $pp+1;
			$searchFlag=undef;
		}
	}
	$i++;
}
sub isPrime {
	my $val=shift;
	my $res=0;
	for (my $i=2; $i<=$val/2; $i++){
		$res++ if ($val%$i) == 0;
	}
	$res==0	;
}

