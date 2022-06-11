#!/usr/bin/raku

#time (bash command): 
#real	0m0.511s
#user	0m0.622s
#sys	0m0.046s


say homeprime(10);
#773
say homeprime(16);
#31636373
say homeprime(20);
#3318308475676071413

#-- sub for home prime

sub homeprime(Int $n) returns Int {
	$n.Int.is-prime && return $n;
	return homeprime(factor($n));
}

#--sub for factorizing

sub factor (Int $n where $n > 1) returns Int {
#-- returns the concatenated prime factors as an int
	$n.Int.is-prime && (return $n.Int );
	my Int $sqrt_n = sqrt($n).Int;

	my @factors=();

	my Str $retstring="";
	my Int $ncopy=$n.Int;	
	
	for (2 .. $sqrt_n) -> $prime {
	#-- no need to generate primes first.. the routine will 
	#-- automatically only choose prime factors
		while ($ncopy %% $prime) {
			$ncopy div= $prime; 	#-- integer division
			@factors.append($prime);
		}
		$ncopy.is-prime && last;
	}
	($ncopy > 1) && @factors.append($ncopy);
	#-- any factor bigger than sqrt(n) is a prime factor
	$retstring = @factors.list.join;

	return $retstring.Int;
}


