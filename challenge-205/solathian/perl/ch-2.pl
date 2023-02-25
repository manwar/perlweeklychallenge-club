#!usr/bin/perl
use v5.36;

# Challange 205 - 2 - Maximum XOR
# You are given an array of integers.
# Write a script to find the highest value obtained by XORing any two distinct members of the array.


# Input: @array = (1,2,3,4,5,6,7)
# Output: 7
# The maximum result of 1 xor 6 = 7.

# Input: @array = (2,4,1,3)
# Output: 7
# The maximum result of 4 xor 3 = 7.

# Input: @array = (10,5,7,12,8)
# Output: 15
# The maximum result of 10 xor 5 = 15.

maXor(1,2,3,4,5,6,7);       # 7
maXor(2,4,1,3);             # 7
maXor(10,5,7,12,8);         # 15

sub maXor(@array)
{
    my $max = 0;
    
    foreach my $value (@array)
    {
        map{ $max = $_ ^ $value     if(($_ ^ $value) > $max) }    @array;

    }
 
    say $max;
}