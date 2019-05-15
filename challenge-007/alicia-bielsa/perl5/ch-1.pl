#Print all the niven numbers from 0 to 50 inclusive, each on their own line. 
#A niven number is a non-negative number that is divisible by the sum of its digits.
use strict;
use warnings;

foreach my $i (0..50){
	if (isNiven($i)){
		print "$i\n";		
	}	
}

 
 sub isNiven {
 	my $number = shift;

    my $sumDigits = 0;
    my @aDigits = split('', $number);
    foreach my $digit (@aDigits){
        $sumDigits +=  $digit;      
    }	
 	if ($sumDigits == 0){
 		return 0; 		
  	}
 	
 	if ($number % $sumDigits == 0){   
 		return 1;
 	}
 	return 0;
 }