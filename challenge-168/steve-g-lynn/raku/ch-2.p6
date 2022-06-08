#!/usr/bin/raku

say homeprime(16);
# 31636373
#-- works but very slow: time real 0m59.301s user 0m58.334s sys 0m0.773s
#-- on MacBook Air running Linux FC36

#-- sub for home prime

sub homeprime(Int $n){
	my $ncopy=$n;
	while (1) {
		$ncopy=factor($ncopy).Int;
		($ncopy.is-prime) && last;
	}
	return $ncopy;
}

#--sub for factorizing

multi sub factor (1) {1}

multi sub factor (Int $n where $n > 1){
#-- returns string concatenation of prime factors
	my @primes=prime_sieve($n);
	my $retstring="";
	my $ncopy=$n;

	($n.is-prime) && (return $n);	
	
	for @primes -> $prime {
		while ( ($ncopy % $prime)==0) {
			$ncopy /= $prime;
			$retstring ~= $prime;
		}
	}
	return $retstring;
}

#--sub for sieve of Eratosthenes
#-- (algorihm from wikipedia)
sub prime_sieve(Int $n where $n > 1){
	my @a = 2..$n;
	my (%retval=(),@retval=());
	for (@a) -> $i {
		%retval{$i}=1;
	}
	my @i= 2..round(sqrt($n));
	for @i -> $i {
		loop ( my $j=($i*$i); $j <= $n; $j += $i){
			%retval{$j}=0;			
		}
	}
	my @k = %retval.keys; 
	for @k -> $k {
		if (%retval{$k}==1) {
			push @retval, $k;
		}
	}
	return (@retval.sort:{$^a <=> $^b});	
}
