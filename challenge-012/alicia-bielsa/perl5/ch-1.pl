#The numbers formed by adding one to the products of the smallest primes are called the Euclid Numbers (see wiki). 
#Write a script that finds the smallest Euclid Number that is not prime. 
#This challenge was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use List::Util  qw(product);
 

my $keepLooking = 1;
my @aPrimeNumbers = ();
my $currentPrimeNumber = 0;

while ($keepLooking){    

   my $nextPrime = getNextPrime( $currentPrimeNumber );
   push (@aPrimeNumbers, $nextPrime );
   $currentPrimeNumber = $nextPrime;
   my $euclidNumber = ( product @aPrimeNumbers )  +1;
   if ( isPrimeNumber($euclidNumber) ){
		  print "Euclid number $euclidNumber is prime, keep looking\n";
   } else {
		print "Found the smallest Euclid Number that is not prime $euclidNumber\n";
		$keepLooking = 0;
   }
}

sub isPrimeNumber {

	my $number = shift;
	my $isPrime = 1;
	
	foreach my $i ( 2..$number-1){
		if ($number  % $i == 0 ){
		   $isPrime = 0;
		}
	}
    return $isPrime;   
}

sub getNextPrime {

	my $start  = shift;
	my $limit = 10000;
	$start++;

	foreach my $number ($start..$limit) {
		if ( isPrimeNumber($number) ){
			return $number;
		} 
	}
}