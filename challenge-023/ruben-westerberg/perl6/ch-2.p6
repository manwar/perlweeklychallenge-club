#!/usr/bin/env perl6


sub MAIN($number) {
	my $primes=(0..*).grep({.is-prime}).cache;
	my @factors;
	my $i=0;
	my $value=$number;
	loop {
		if $value%%$primes[$i] {
			$value/=$primes[$i];
			@factors.push: $primes[$i];
			$i=0;
		}
		else {
			$i++;
		}
		last if $primes[$i]>$value;
	}
	put "Prime decomposition of $number: @factors[]" if @factors >1;
	put  "No decomposition for $number" if @factors ==1;
}
