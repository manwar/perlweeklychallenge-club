#! /usr/bin/env gforth

\ Challenge 204
\
\ Task 1: Monotonic Array
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
\
\     An array is Monotonic if it is either monotone increasing or decreasing.
\
\ Monotone increasing: for i <= j , nums[i] <= nums[j]
\ Monotone decreasing: for i <= j , nums[i] >= nums[j]
\
\
\ Example 1
\
\ Input: @nums = (1,2,2,3)
\ Output: 1
\
\ Example 2
\
\ Input: @nums = (1,3,2)
\ Output: 0
\
\ Example 3
\
\ Input: @nums = (6,5,5,4)
\ Output: 1


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


\ check if list is monotonic
: is_monotonic ( -- f )
    num_items 2 < IF 1
    ELSE
        0 0 { climbing descending }
        num_items 1- 0 DO
            I 1+ items[] @
            I items[] @
            2DUP > IF 1 TO climbing THEN
            < IF 1 TO descending THEN
        LOOP
        climbing descending AND IF 0 ELSE 1 THEN
    ENDIF
;

collect_args is_monotonic . CR
BYE
