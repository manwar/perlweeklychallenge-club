use strict;
use warnings;
##
# Write a script to display the first 20 Leonardo Numbers.
##
use constant NUMBERS => 20; 
my $numbers = NUMBERS;
my @leonardo = (1, 1); 
while($numbers){
    if((NUMBERS - $numbers) < 2){
        print "L(" . (NUMBERS - $numbers) . ") = " . $leonardo[-1] . "\n";  
    }  
    else{
        my $leonardo = $leonardo[-1] + $leonardo[-2] + 1;  
        print "L(" . (NUMBERS - $numbers) . ") = $leonardo\n";
        push @leonardo, $leonardo;
    } 
    $numbers--;
}
