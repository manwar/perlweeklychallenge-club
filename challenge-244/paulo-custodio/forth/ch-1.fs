#! /usr/bin/env gforth

\ Challenge 244
\
\ Task 1: Count Smaller
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to calculate the number of integers smaller than the integer
\ at each index.
\ Example 1
\
\ Input: @int = (8, 1, 2, 2, 3)
\ Output: (4, 0, 1, 1, 3)
\
\ For index = 0, count of elements less 8 is 4.
\ For index = 1, count of elements less 1 is 0.
\ For index = 2, count of elements less 2 is 1.
\ For index = 3, count of elements less 2 is 1.
\ For index = 4, count of elements less 3 is 3.
\
\ Example 2
\
\ Input: @int = (6, 5, 4, 8)
\ Output: (2, 1, 0, 3)
\
\ Example 3
\
\ Input: @int = (2, 2, 2)
\ Output: (0, 0, 0)

CREATE nums     256 CELLS ALLOT
CREATE smaller  256 CELLS ALLOT

: array_size ( arr-addr -- size-addr )
;

: array[] ( arr-addr i -- elem-addr )
    1+ CELLS +
;

: array_push_back ( arr-addr n -- )
    { arr n }
    arr array_size @    ( size )
    arr SWAP array[]    ( elem-addr )
    n SWAP !
    arr array_size 1 SWAP +!
;

: .array ( arr -- )
    { arr }
    arr array_size @ 0 ?DO
        arr I array[] @ .
    LOOP
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        nums SWAP array_push_back
    REPEAT
    2DROP
;

: compute_smaller ( -- )
    nums array_size @ 0 ?DO
        0           ( count )
        nums array_size @ 0 ?DO
            nums I array[] @  nums J array[] @  <  IF 1+ THEN
        LOOP
        smaller SWAP array_push_back
    LOOP
;

collect_args
compute_smaller
smaller .array
BYE
