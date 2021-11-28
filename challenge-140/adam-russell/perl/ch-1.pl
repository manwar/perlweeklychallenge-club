use strict;
use warnings;
##
# You are given two decimal coded binary numbers $a and $b.
# Write a script to simulate the addition of the binary numbers. 
##

sub add_binary{
    my($x, $y) = @_;
    my $sum = ""; 
    my @a = reverse(split(//, $x));            
    my @b = reverse(split(//, $y));            
    if(@b > @a){
        my @c = @b;
        @b = @a;
        @a = @c;   
    } 
    my $carry = 0; 
    for(my $d = 0; $d <= @a - 1; $d++){ 
        my $d0 = $a[$d]; 
        my $d1 = $b[$d];
        if($d1){
            $sum = "0$sum", $carry = 0 if $d0 == 1 && $d1 == 1 && $carry == 1;  
            $sum = "1$sum", $carry = 0 if $d0 == 1 && $d1 == 0 && $carry == 0; 
            $sum = "0$sum", $carry = 1 if $d0 == 1 && $d1 == 1 && $carry == 0; 
            $sum = "0$sum", $carry = 1 if $d0 == 0 && $d1 == 1 && $carry == 1; 
            $sum = "0$sum", $carry = 0 if $d0 == 0 && $d1 == 0 && $carry == 0; 
            $sum = "1$sum", $carry = 0 if $d0 == 0 && $d1 == 0 && $carry == 1; 
            $sum = "0$sum", $carry = 1 if $d0 == 1 && $d1 == 0 && $carry == 1; 
            $sum = "1$sum", $carry = 0 if $d0 == 0 && $d1 == 1 && $carry == 0; 
        } 
        else{
            $sum = "0$sum", $carry = 1, next if $d0 == 1 && $carry == 1;  
            $sum = "1$sum", $carry = 0, next if $d0 == 0 && $carry == 1;  
            $sum = "0$sum", $carry = 0, next if $d0 == 0 && $carry == 0;  
            $sum = "1$sum", $carry = 0, next if $d0 == 1 && $carry == 0;  
        }  
    } 
    $sum = "$carry$sum" if $carry == 1;  
    return $sum; 
}

MAIN:{
    print add_binary(11, 1) . "\n"; 
    print add_binary(101, 1) . "\n"; 
    print add_binary(100, 11) . "\n"; 
}
