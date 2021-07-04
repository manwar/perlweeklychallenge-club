use strict;
use warnings;
##
# You are given a positive integer $N.
# Write a script to swap the two nibbles 
# of the binary representation of the 
# given number and print the decimal 
# number of the new binary representation.
sub swap_nibbles{
    my($n) = @_;
    my $bits = substr(unpack("B32", pack("N", shift)), 24, 8);  
    my $swapped_bits = substr($bits, 4) . substr($bits, 0, 4);
    my $swapped_decimal = unpack("N", pack("B32", substr("0" x 32 . $swapped_bits, -32)));
    print $swapped_decimal . "\n";   
}

MAIN:{
    swap_nibbles(101);
    swap_nibbles(18);
}
