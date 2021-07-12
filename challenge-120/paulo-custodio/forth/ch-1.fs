#! /usr/bin/env gforth

\ Challenge 120
\
\ TASK #1 - Swap Odd/Even bits
\ Submitted by: Mohammad S Anwar
\ You are given a positive integer $N less than or equal to 255.
\
\ Write a script to swap the odd positioned bit with even positioned bit and
\ print the decimal equivalent of the new binary representation.
\
\ Example
\ Input: $N = 101
\ Output: 154
\
\ Binary representation of the given number is 01 10 01 01.
\ The new binary representation after the odd/even swap is 10 01 10 10.
\ The decimal equivalent of 10011010 is 154.
\
\ Input: $N = 18
\ Output: 33
\
\ Binary representation of the given number is 00 01 00 10.
\ The new binary representation after the odd/even swap is 00 10 00 01.
\ The decimal equivalent of 100001 is 33.

: swap_bits     { n -- n }
    0 0         { out shift }
    BEGIN n 0> WHILE
        n 1 AND IF  2 shift LSHIFT out OR  TO out  THEN
        n 2 AND IF  1 shift LSHIFT out OR  TO out  THEN
        n 2 RSHIFT  TO n
        shift 2 +  TO shift
    REPEAT
    out ;

NEXT-ARG S>NUMBER? 0= THROW DROP
swap_bits . CR BYE
