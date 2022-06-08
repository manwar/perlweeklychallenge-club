#!/usr/bin/perl

use Math::Prime::XS qw(is_prime sieve_primes);


print &home_prime(16),"\n";
#-- should be 31636373 [wikipedia example]

sub home_prime {
	local ($n)=@_;
	while (1){
		$n=&factors($n);
		(is_prime($n)) && last;
	}
	return $n;
}


sub factors {
	#--return concatenated prime factors of a number n 
	local ($n)=@_;
	local @primes=sieve_primes($n);
	local $retstring="";
	
	if (is_prime($n)){
		return $n;
	}
	else {
		foreach $prime (sort{$a<=>$b} @primes){
			while ( ($n % $prime) == 0){
				$n /= $prime;
				$retstring .= $prime;
			}
		}
	}
	return $retstring;	
}
