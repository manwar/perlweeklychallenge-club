#! /usr/bin/env gforth

\ Challenge 202
\
\ Task 2: Widest Valley
\ Submitted by: E. Choroba
\
\ Given a profile as a list of altitudes, return the leftmost widest valley.
\ A valley is defined as a subarray of the profile consisting of two parts:
\ the first part is non-increasing and the second part is non-decreasing.
\ Either part can be empty.
\
\ Example 1
\
\ Input: 1, 5, 5, 2, 8
\ Output: 5, 5, 2, 8
\
\ Example 2
\
\ Input: 2, 6, 8, 5
\ Output: 2, 6, 8
\
\ Example 3
\
\ Input: 9, 8, 13, 13, 2, 2, 15, 17
\ Output: 13, 13, 2, 2, 15, 17
\
\ Example 4
\
\ Input: 2, 1, 2, 1, 3
\ Output: 2, 1, 2
\
\ Example 5
\
\ Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
\ Output: 3, 3, 2, 1, 2, 3, 3

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

: largest_valey ( -- r+1 l )
    0 -1 { l1 r1 }              \ initial interval

    \ find largest valey
    nums_size 0 ?DO             \ center of valey
        I I { l r }             \ left right

        BEGIN l 1- 0 >=  l 1- nums[] @  l nums[] @  >= AND WHILE
            l 1- TO l
        REPEAT

        BEGIN r 1+ nums_size <  r 1+ nums[] @  r nums[] @ >= AND WHILE
            r 1+ TO r
        REPEAT

        r l -  r1 l1 - > IF
            l TO l1
            r TO r1
        THEN
    LOOP

    r1 1+ l1
;

: task
    collect_args largest_valey ?DO
        i nums[] @ .
    LOOP
    CR
;

task
BYE
