#! /usr/bin/env gforth

\ Challenge 243
\
\ Task 1: Reverse Pairs
\ Submitted by: Mohammad S Anwar
\ You are given an array of integers.
\
\ Write a script to return the number of reverse pairs in the given array.
\
\ A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
\
\ Example 1
\ Input: @nums = (1, 3, 2, 3, 1)
\ Output: 2
\
\ (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
\ (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
\ Example 2
\ Input: @nums = (2, 4, 3, 5, 1)
\ Output: 3
\
\ (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
\ (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
\ (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

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

: count_reverse_pairs ( -- n )
    0 { count }
    nums_size 1- 0 DO
        nums_size I 1+ DO
            J nums[] @  I nums[] @ 2* > IF
                count 1+ TO count
            THEN
        LOOP
    LOOP
    count
;

\ main
collect_args
count_reverse_pairs . CR
BYE
