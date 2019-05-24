#Write a script that computes the first five perfect numbers. 
#A perfect number is an integer that is the sum of its positive proper divisors
#(all divisors except itself). 

use strict;
use warnings;

my @aPrimeNumbers = getPrimeNumbers(5); 

foreach my $primeNumber (@aPrimeNumbers){
	print 2 ** ($primeNumber -1) * ( 2 ** $primeNumber -1 )."\n";	
}


sub getPrimeNumbers {
	my $totalNumbers = shift;
	my @aPrimes = ();
	my $limit = 1000;
	foreach my $number ( 2..$limit ){
	    my $isPrime = 1;
		foreach my $i ( 2..$number-1){
			if ($number  % $i == 0 ){
				$isPrime = 0;
			}
		}
		if ( $isPrime ){
			push ( @aPrimes , $number );
		}
		last if (scalar(@aPrimes) == $totalNumbers);	
	}
	return @aPrimes;
}
