#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

# Challange 192 - 1 - Binary Flip
# You are given a positive integer, $n.
# Write a script to find the binary flip.

# First find the binary equivalent of the given integer, 101.
# Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
# So Binary 010 => Decimal 2.

# assumptions, the given value is certainly a number and it can be stored on 32bits
sub bFlip($number)
{
    say unpack("N", pack("B32", substr("0" x 32 . join('', map( $_= $_ == 0 ? 1 : 0,  split('', sprintf('%b', $number)))), -32)));
}


# in a more cultured and readable manner
sub bFlip2($number)
{
    # converting it to binary
    $number = sprintf('%b', $number);
    
    # splitting it into an array
    my @array = split('', $number);
    
    # flip bits in the array with map and a tenary operator
    @array = map( $_= $_ == 0 ? 1 : 0, @array);
    
    # re-create the string 
    $number = join('', @array);
    
    # pad to be a 32bit binary
    $number = substr("0" x 32 . $number, -32);  # "If OFFSET is negative, starts that far back from the end of the string." - So only 32 chracters will be kept
    
    # pack it as 32bit -  B:  A bit string (descending bit order inside each byte).
    $number = pack("B32", $number);
    
    #unpack N - N  An unsigned long (32-bit) in "network" (big-endian) order.
    $number = unpack("N", $number);

    say $number;    
}

#tests 
# my $inp0 = 5;    #     Output: 3   
# bFlip($inp0);
# bFlip2($inp0);

# my $inp1 = 4;    #     Output: 3   
# bFlip($inp1);
# bFlip2($inp1);

# my $inp2 = 6;    #     Output: 1   
# bFlip($inp2);
# bFlip2($inp2);