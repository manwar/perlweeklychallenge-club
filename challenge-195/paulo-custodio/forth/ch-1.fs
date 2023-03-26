#! /usr/bin/env gforth

\ Challenge 195
\
\ Task 1: Special Integers
\ Submitted by: Mohammad S Anwar
\ You are given a positive integer, $n > 0.
\
\ Write a script to print the count of all special integers between 1 and $n.
\
\ An integer is special when all of its digits are unique.
\
\ Example 1:
\ Input: $n = 15
\ Output: 14 as except 11 all other integers between 1 and 15 are spcial.
\ Example 2:
\ Input: $n = 35
\ Output: 32 as except 11, 22, 33 all others are special.

CREATE digits 10 CELLS ALLOT

: clear_digits ( -- ) digits 10 CELLS ERASE ;

: count_digits ( n -- )
    BEGIN DUP 0> WHILE
        DUP 10 MOD CELLS digits + 1 SWAP +!
        10 /
    REPEAT
    DROP
;

: has_duplicate_digit ( -- f )
    FALSE
    10 0 DO
        I CELLS digits + @ 1 > IF DROP TRUE THEN
    LOOP
;

: is_special_digit ( n -- f )
    clear_digits
    count_digits
    has_duplicate_digit 0=
;

: count_special_ints ( n -- count )
    0 SWAP
    1+ 1 ?DO
        I is_special_digit IF 1+ THEN
    LOOP
;

NEXT-ARG 0 0 2SWAP >NUMBER 2DROP DROP
count_special_ints . CR
BYE
