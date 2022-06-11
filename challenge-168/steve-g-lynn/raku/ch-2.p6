#!/usr/bin/raku

#time (bash command): 
#real	0m0.490s
#user	0m0.729s
#sys	0m0.056s


# acknowledgement:

# I improved the previous grossly inefficient version 
# (> 1 min script run time) after looking 
# at the raku and python submissions from Roger Bell-West


say homeprime(10);
#773
say homeprime(16);
#31636373

#-- sub for home prime

sub homeprime(Int $n) returns Int { 
	$n.Int.is-prime && return $n;
	my $ncopy=$n;
	while (1) {
		my $last=$ncopy;
		$ncopy=factor($ncopy);
		($ncopy==$last) && last;
	}
	return $ncopy;
}

#--sub for factorizing

multi sub factor (1) returns Int {1}

multi sub factor (Int $n where $n > 1) returns Int {
#-- returns the concatenated prime factors as an int
	$n.Int.is-prime && (return $n.Int );
	my $sqrt_n = sqrt($n).Int+1;
	my @primes=find_primes($sqrt_n);
	my @factors=();

	my $retstring="";
	my $ncopy=$n;	
	
	for @primes -> $prime {
		while ( ($ncopy % $prime)==0) {
			$ncopy /= $prime;
			push @factors, $prime;
		}
	}
	($ncopy > 1) && push @factors, $ncopy;
	#-- any factor bigger than sqrt(n) is a prime factor
	$retstring = @factors.list.join;

	return $retstring.Int;
}

multi sub find_primes(Int $n where $n <= 100) {
	my @primes=
	(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97); 
	my @retval=();
	for @primes -> $prime {
		($prime < $n) && (push @retval, $prime);
	}
	return (@retval.sort);
}

multi sub find_primes (Int $n where $n > 100) {
	my @primes=[7,11,13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]; #-- candidate primes
	my %primes{Int}=(); #-- we will return keys of this
	my $sqrt_n = sqrt($n); #-- ceiling for iterating thru' sieve
	
	#-- initialize primes hash
	#-- store candidates of the form 6k-1 to 6k+1
	#-- eliminate multiples of known primes
	loop (my $i=102; $i <= $n+1; $i += 6) {
		my @temp=($i-1, $i+1);
		TEMP: for @temp -> $temp {
			($temp % 3) || next;
			($temp % 5) || next;
			for @primes -> $prime {
				($prime > $sqrt_n) && last;
				($temp % $prime) || next TEMP;
			}
			($temp <= $n) && (%primes{$temp}=True);
		}
	}
		
	#-- for prime candidates k greater than @primes[*-1]
	#-- use odd numbers not divisible by 3 (last value + 4 and +6 if
	#   we start counting from 97)
	#-- loop through factors kk+jk < n and delete
	#-- any %hash entries with key matching these factors.

	my $last_prime = @primes[*-1];
	if ($last_prime < $sqrt_n) { 
		@primes=[$last_prime+4, $last_prime+2];
		while (1) {
			my $prime = shift @primes;
			(@primes.elems==0) && 
				(@primes.append($prime+4, $prime+2));
			#-- avoid multiples of 3
			
			last if $prime > $sqrt_n;
		
			#-- only loop if the candidate is in the primes hash
			if  ( %primes{$prime} ) {
				loop (my $i=$prime*$prime; 
					$i <= $n;
					$i += $prime) {
						%primes{$i}:delete;
				}
			}
		}
	}
	my @retval=(2,3,5,7,11,13,17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97);
	return (@retval.append(%primes.keys.sort));

	return 1;
}



