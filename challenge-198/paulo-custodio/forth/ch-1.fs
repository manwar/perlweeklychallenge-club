#! /usr/bin/env gforth

\ Challenge 198
\
\ Task 1: Max Gap
\ Submitted by: Mohammad S Anwar
\ You are given a list of integers, @list.
\
\ Write a script to find the total pairs in the sorted list where 2 consecutive
\ elements has the max gap. If the list contains less then 2 elements then
\ return 0.
\
\
\ Example 1
\ Input:  @list = (2,5,8,1)
\ Output: 2
\
\ Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
\ Example 2
\ Input: @list = (3)
\ Output: 0

0 VALUE nums
0 VALUE nums_size

: nums[] ( i -- addr )
    CELLS nums +
;

\ collect arguments from input, convert to minutes and store in items
: collect_args ( -- )
    HERE TO nums
    BEGIN NEXT-ARG DUP WHILE        \ while argments
        0 0 2SWAP >NUMBER 2DROP DROP ,
    REPEAT
    2DROP
    HERE nums - CELL / TO nums_size
;

\ sort array of integers
: sort ( -- )
    nums_size 1- 0 DO
        nums_size I 1+ DO
            J nums[] @
            I nums[] @
            > IF
                J nums[] @ I nums[] @ J nums[] ! I nums[] !
            THEN
        LOOP
    LOOP
;

\ count max gaps
: max_gap ( -- n )
    0               ( count )
    nums_size 2 >= IF
        sort
        0 { max_gap }
        nums_size 1- 0 DO
            I 1+ nums[] @  I nums[] @  - { gap }
            gap max_gap > IF
                gap TO max_gap
                DROP 1
            ELSE gap max_gap = IF
                1+
            THEN THEN
        LOOP
    THEN
;

collect_args max_gap . CR
BYE
