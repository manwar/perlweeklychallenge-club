#!/usr/bin/perl

use Math::Prime::XS qw(is_prime);

print &home_prime(10),"\n";
#773
print &home_prime(16),"\n";
#31636373
print &home_prime(20),"\n";
#3318308475676071413

sub home_prime {
	my ($n)=@_;
	is_prime($n) && return $n;
	while (1){
		$n=&factors($n);
		(is_prime($n)) && last;
	}
	return $n;
}


sub factors {
	#--return concatenated prime factors of a number n 
	my ($n)=@_;
	local $sqrt_n=int(sqrt($n));

	my $retstring="";
	
	if (is_prime($n)){
		return $n;
	}
	else {
		for $prime (2 .. $sqrt_n){
		#-- no need to get primes first
		#-- routine automatically finds only prime factors
			while ( ($n % $prime) == 0){
				$n /= $prime;
				$retstring .= $prime;
			}
			(is_prime($n)) && last; 
		}
		($n > 1) && ($retstring .= $n);
	}
	return $retstring;	
}
