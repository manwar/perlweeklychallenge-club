#!/usr/bin/env perl6

for 1..50  {
	my @a=primeFactors($_).flat;
	put "Attractive number $_: prime factors @a[]" if @a.is-prime;
}

sub primeFactors($i) {
	gather {
		for 1..$i/2 {
			if ($i%%$_) && $_.is-prime {
				take $_;
				given $i/$_ {
					if .is-prime {
						take $_;
					}
					else { 
						take (|primeFactors($_));
					}
					last;
				}
			}
		}
	}
}
