#!/usr/bin/env perl6
#
#
#       119-1-nibble-n-swap.raku
#
#       Swap Nibbles
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to swap the two nibbles of the binary representation of
#         the given number and print the decimal number of the new binary
#         representation.
# 
#         A nibble is a four-bit aggregation, or half an octet.
# 
#         To keep the task simple, we only allow integer less than or equal to
#         255.
# 
#         Example
#         Input: $N = 101
#         Output: 86
# 
#         Binary representation of decimal 101 is 1100101 or as 2 nibbles (0110)(0101).
#         The swapped nibbles would be (0101)(0110) same as decimal 86.
# 
#         Input: $N = 18
#         Output: 33
# 
#         Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
#         The swapped nibbles would be (0010)(0001) same as decimal 33.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Int $num where 256 > $num > 0 = 3) ;

$num.fmt("%08b") 
    .comb(4)
    .reverse
    .join
    .parse-base(2)
    .say;









