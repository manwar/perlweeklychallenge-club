use strict;
use warnings;
##
# You are given a positive integer $N less than or equal to 255.
# Write a script to swap the odd positioned bits with the even 
# positioned bits and print the decimal equivalent of the new binary representation.
##
sub swap_bits{
    my($n) = @_;
    my $bits = substr(unpack("B32", pack("N", shift)), 24, 8);
    my @bits = split(//, $bits);
    for(my $i = 0; $i < @bits; $i += 2){
        @bits[$i, $i + 1] = @bits[$i + 1, $i]; 
    }  
    my $swapped_decimal = unpack("N", pack("B32", substr("0" x 32 . join("", @bits), -32)));
    return $swapped_decimal; 
}

MAIN:{
    my $N;
    $N = 101; 
    print swap_bits($N) . "\n";
    $N = 18; 
    print swap_bits($N) . "\n";
}   
