#! /usr/bin/env gforth

\ Challenge 199
\
\ Task 1: Good Pairs
\ Submitted by: Mohammad S Anwar
\
\ You are given a list of integers, @list.
\
\ Write a script to find the total count of Good Pairs.
\
\     A pair (i, j) is called good if list[i] == list[j] and i < j.
\
\
\ Example 1
\
\ Input: @list = (1,2,3,1,1,3)
\ Output: 4
\
\ There are 4 good pairs found as below:
\ (0,3)
\ (0,4)
\ (3,4)
\ (2,5)
\
\ Example 2
\
\ Input: @list = (1,2,3)
\ Output: 0
\
\ Example 3
\
\ Input: @list = (1,1,1,1)
\ Output: 6
\
\ Good pairs are below:
\ (0,1)
\ (0,2)
\ (0,3)
\ (1,2)
\ (1,3)
\ (2,3)

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

: count_good_pairs ( -- n )
    0               ( count )
    nums_size 2 >= IF
        nums_size 1-  0  DO
            nums_size  I 1+  DO
                I nums[] @  J nums[] @  = IF 1+ THEN
            LOOP
        LOOP
    THEN
;

collect_args count_good_pairs . CR
BYE
