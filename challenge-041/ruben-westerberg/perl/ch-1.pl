#!/usr/bin/env perl
use strict;
use warnings;
for (1..50) {
	my @a=primeFactors($_);
	print "Attractive number $_: prime factors @a\n" if (prime(scalar @a));
}
sub prime {
	my $n=shift;
	if ($n <= 3 ) {
		return $n > 1;
	}
	elsif ($n % 2 == 0 or $n % 3 ==0 ) {
		return 0;
	}
	my $i=5;
	while ($i**2 <= $n) {
		if ( $n % $i ==0 or $n % ($i+2) == 0 ) {
				return 0;
		}
		$i+=6;
	}
	return 1;
}

sub primeFactors {
	my @factors;
	my $i=shift;
	for (1..$i/2) {
		if ($i%$_ == 0 and prime $_ ) {
			my $b=$i/$_;
			push @factors, $_;
			if (prime $b) {
				push @factors, $b;
			}
			else {
				push @factors, primeFactors($b);
			}
			last;
		}
	}
	@factors;
}

