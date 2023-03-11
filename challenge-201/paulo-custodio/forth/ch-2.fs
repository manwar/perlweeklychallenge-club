#! /usr/bin/env gforth

\ Challenge 201
\
\ Task 2: Penny Piles
\ Submitted by: Robbie Hatley
\
\ You are given an integer, $n > 0.
\
\ Write a script to determine the number of ways of putting $n pennies in a row
\ of piles of ascending heights from left to right.
\ Example
\
\ Input: $n = 5
\ Output: 7
\
\ Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
\
\     1 1 1 1 1
\     1 1 1 2
\     1 2 2
\     1 1 3
\     2 3
\     1 4
\     5

: make_piles1 { prev n -- count }
    0                           ( count )
    n 0= IF
        1+                      \ count++
    ELSE n 0 > IF
        prev 0 < IF n ELSE prev THEN 1+
        1 DO
            I  n I -  RECURSE
            +
        LOOP
    THEN THEN
;

: make_piles ( n )
    -1 SWAP make_piles1
;


NEXT-ARG DUP 0= THROW 0 0 2SWAP >NUMBER 2DROP DROP      \ get n
make_piles . CR
BYE
