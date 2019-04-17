use strict;
use warnings;
##
# Write a script to output the same number of PI digits as the size of your script.
# Say, if your script size is 10, it should print 3.141592653.
##
use bignum;  

sub pi{
    my($max) = @_;  
    my @digits;  
    my($k, $a, $b, $a1, $b1) = (2, 4, 1, 12, 4);  
    while(@digits < $max){
        my($p, $q) = ($k ** 2, 2 * $k + 1); 
        $k = $k + 1;  
        ($a, $b , $a1, $b1) = ($a1, $b1, $p * $a + $q * $a1, $p * $b + $q * $b1);   
        my($d, $d1) = (int($a/$b), int($a1/$b1));  
        while($d == $d1){
            push @digits, $d;   
            if(@digits >= $max){
                return \@digits;  
            }  
            ($a, $a1) = (10 * ($a % $b), 10 * ($a1 % $b1));  
            ($d, $d1) = (int($a / $b), int($a1 / $b1));  
        }     
    }  
    return \@digits;  
}  

##
# Main 
##
my $digits=pi((stat($0))[7]);  
print $digits->[0] . "." . join("", @{$digits}[1 .. @{$digits} - 1]); 
