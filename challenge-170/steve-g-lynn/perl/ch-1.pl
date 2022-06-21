#!/usr/bin/perl

use Math::Prime::Util::GMP qw(next_prime);

for my $i (0 .. 10){
	print &primorial($i)," ";
}

print "\n";


sub primorial {
	#-- old-fashioned perl using dynamic scope and typeglobs
	local ($n) = @_;
	
	#-- nested private sub: recursively find the n'th prime
	local *nth_prime = sub {
		local ($n)=@_;
		
		if ($n==0){
			return 1;
		} else {
			return next_prime( 
				&nth_prime (
					$n-1
				) );
		}	
	};

	#-- back to primorial sub: recursively compute primorial
	if ($n==0){
		return 1;
	} else {
		return &nth_prime($n)*&primorial($n-1);
	}	
}

