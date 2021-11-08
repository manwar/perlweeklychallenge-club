=begin
    TASK #1 › Swap Odd/Even bits
    Submitted by: Mohammad S Anwar
    You are given a positive integer $N less than or equal to 255.

    Write a script to swap the odd positioned bit with even positioned bit and print the decimal equivalent of the new binary representation.

    Example
    Input: $N = 101
    Output: 154

    Binary representation of the given number is 01 10 01 01.
    The new binary representation after the odd/even swap is 10 01 10 10.
    The decimal equivalent of 10011010 is 154.

    Input: $N = 18
    Output: 33

    Binary representation of the given number is 00 01 00 10.
    The new binary representation after the odd/even swap is 00 10 00 01.
    The decimal equivalent of 100001 is 33.

=end
=cut 

use warnings;
use strict;
use Data::Dumper;
    
my $N = 101;
my @bits;
my $newNumber = '';

splitBinary();


sub splitBinary {
    @bits = split(//, sprintf ("%b", $N));
    if (@bits % 2 != 0){
        unshift @bits, '0';
    }
    swapNumbers();
}

sub swapNumbers {
    foreach(my $i=0;$i<@bits;$i+=2){
        $newNumber = $newNumber.$bits[$i+1].$bits[$i];
    }
    convertDecimal();
}

sub convertDecimal {
    my $result = eval("0b$newNumber");
    print("Output: $result");
}


