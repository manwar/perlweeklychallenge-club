#! /usr/bin/env gforth

\ Challenge 202
\
\ Task 1: Consecutive Odds
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to print 1 if there are THREE consecutive odds in the given array
\ otherwise print 0.
\
\ Example 1
\
\ Input: @array = (1,5,3,6)
\ Output: 1
\
\ Example 2
\
\ Input: @array = (2,6,3,5)
\ Output: 0
\
\ Example 3
\
\ Input: @array = (1,2,3,4)
\ Output: 0
\
\ Example 4
\
\ Input: @array = (2,3,5,7)
\ Output: 1

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( i -- addr )
    CELLS nums +
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        nums_size nums[] !
        nums_size 1+ TO nums_size
    REPEAT
    2DROP
;

: is_odd ( n -- f )
    2 MOD 1 =
;

: three_consecutive_odds ( -- n )
    0
    nums_size 3 >= IF
        nums_size 2 - 0 DO
            I nums[] @ is_odd
            I 1+ nums[] @ is_odd AND
            I 2 + nums[] @ is_odd AND
            IF
                DROP 1
                LEAVE
            THEN
        LOOP
    THEN
;

collect_args three_consecutive_odds . CR
BYE
