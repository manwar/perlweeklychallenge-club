use strict;
use warnings;
##
# Print all the niven numbers from 0 to 50 inclusive, each on their own line. 
# A niven number is a non-negative number that is divisible by the sum of its digits.
## 
use constant NIVEN_COUNT => 50;
my $i = 1;  
my $count = 0;
do{
    my @digits = split(//,$i); 
    my $digit_sum = unpack("%32C*", pack("C*", @digits));   
    if($i % $digit_sum == 0){ 
        print "$i ";  
        $count++;  
    }  
    $i++;   
}while($count < NIVEN_COUNT);
print "\n";   
