#! /usr/bin/env gforth

\ Challenge 205
\
\ Task 2: Maximum XOR
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to find the highest value obtained by XORing any two distinct members of the array.
\ Example 1
\
\ Input: @array = (1,2,3,4,5,6,7)
\ Output: 7
\
\ The maximum result of 1 xor 6 = 7.
\
\ Example 2
\
\ Input: @array = (2,4,1,3)
\ Output: 7
\
\ The maximum result of 4 xor 3 = 7.
\
\ Example 3
\
\ Input: @array = (10,5,7,12,8)
\ Output: 15
\
\ The maximum result of 10 xor 5 = 15.


\ array of numbers, setup by collect-args
0 VALUE items                       \ array of numbers
0 VALUE num_items                   \ number of elements

: items[] ( i -- addr )
    CELLS items +
;


\ collect arguments from input and store in items
: collect_args ( -- )
    HERE TO items
    BEGIN NEXT-ARG DUP WHILE        \ while argments
        0 0 2SWAP >NUMBER 2DROP DROP ,
    REPEAT
    2DROP
    HERE items - CELL / TO num_items
;


\ compute max of XOR of all pairs
: max_xor ( -- n )
    0                               ( max )
    num_items 1 > IF
        num_items 1-  0  DO
            num_items  I 1+  DO
                I items[] @
                J items[] @  XOR  MAX
            LOOP
        LOOP
    THEN
;


collect_args max_xor . CR
BYE
