use strict;
use warnings;
##  
# Write a script that computes the first five perfect numbers. 
# A perfect number is an integer that is the sum of its positive 
# proper divisors (all divisors except itself). 
##
use Perfect;  
use constant PERFECT_COUNT => 5;

my $i = 2; 
my $count = 0; 
my $p = new Perfect::Perfect();  
do{
    if($p->isPerfect($i)){  
        print "$i ";   
        $count++;   
    }    
    $i++;   
}while($count < PERFECT_COUNT);
print "\n";   
