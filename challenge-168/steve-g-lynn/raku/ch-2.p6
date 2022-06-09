#!/usr/bin/raku

say homeprime(16);
# 31636373
#-- works but slow

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
#	my @primes=prime_sieve($n);
	my @primes=find_primes($n);
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

multi sub find_primes(Int $n where $n <= 13) {
	my @primes=(2,3,5,7,11,13);
	my @retval=();
	for @primes -> $prime {
		($prime < $n) && (push @retval, $prime);
	}
	return (@retval.sort);
}

multi sub find_primes(Int $n where $n > 13) {
#-- naive approach by trial factorization    
    my @primes=(3,7,11,13);
    
    my $i=13;
    
    while ($i < $n) {
    	#-- count only odd numbers not ending in 5. Take 4 at a time.
        my @testarray=();
    
    	(($i+4) < $n) && (push @testarray, ($i+4));
        (($i+6) < $n) && (push @testarray, ($i+6));
        (($i+8) < $n) && (push @testarray, ($i+8));
        (($i+10) < $n) && (push @testarray, ($i+10));

        while (@testarray.elems > 0) {
            my $testitem=shift(@testarray);
            unless ((($testitem % 6)==1) || (($testitem % 6)==5)) {
            #-- use the property that prime numbers above 5 are 6k+1 or 6k-1  
            	next;
            }
            for @primes -> $prime {
                ($prime > sqrt($testitem)) && last;
                (($testitem % $prime)==0) && last;
            }
            push @primes, $testitem;
        }
        $i += 10;
    }

    splice(@primes,0,1, <2 3 5>); #-- left out 2 and 5 earlier to avoid
    				  #   unnecessary redundant factorizing
    return (@primes.sort);
}


