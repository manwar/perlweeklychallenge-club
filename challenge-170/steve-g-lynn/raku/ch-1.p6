#!/usr/bin/raku

use Inline::Perl5;
use Math::Prime::Util::GMP:from<Perl5> <next_prime>;

for (0 .. 10) -> $n {
	print primorial($n)," ";
}

say "";

sub primorial (UInt $n){
	if ($n==0) {
		return 1;
	}  else {
		return nth-prime($n) * primorial($n-1);
	}	
}

#recursively find the n'th prime
sub nth-prime (UInt $n) {
	if ($n==0) {
		return 1;
	} else {
	 	return next_prime( 
			nth-prime ($n-1) );
	}	
}

