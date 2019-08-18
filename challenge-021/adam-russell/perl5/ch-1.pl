use strict;
use warnings;
##
# Write a script to calculate the value of e. 
## 
sub e_calculation{ 
    my($n) = @_; 
    my @d; 
    my $m = 4;
    my @coefficients; 
    my $test = ($n + 1) * (2.30258509);
    do{
        $m++; 
    }while($m * (log($m) - 1.0) + 0.5 * log(6.2831852 * $m) <= $test);    
    @coefficients = (1) x $m; 
    $d[0] = 2;
    for my $i (1 .. $n){
        my $carry = 0;
        for(my $j = $m - 1; $j >= 2; $j--){
            my $temp = $coefficients[$j] * 10 + $carry;
            $carry = int($temp / $j);
            $coefficients[$j] = $temp - $carry * $j; 
        }  
        $d[$i] = $carry;  
    }     
    return @d; 
} 

MAIN:{
    my $number_digits = $ARGV[0];  
    my @digits = e_calculation($number_digits);
    print shift @digits;
    print ".";
    print join("", @digits) . "\n";  
} 
