#! /usr/bin/env gforth

\ Challenge 208
\
\ Task 2: Duplicate and Missing
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers in sequence with one missing and one duplicate.
\
\ Write a script to find the duplicate and missing integer in the given array.
\ Return -1 if none found.
\
\ For the sake of this task, let us assume the array contains no more than one
\ duplicate and missing.
\
\ Example 1:
\
\ Input: @nums = (1,2,2,4)
\ Output: (2,3)
\
\ Duplicate is 2 and Missing is 3.
\
\ Example 2:
\
\ Input: @nums = (1,2,3,4)
\ Output: -1
\
\ No duplicate and missing found.
\
\ Example 3:
\
\ Input: @nums = (1,2,3,3)
\ Output: (3,4)
\
\ Duplicate is 3 and Missing is 4.

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

: count_nums { n -- count }
    0
    nums_size 0 ?DO
        I nums[] @ n = IF 1+ THEN
    LOOP
;

: print_dups_missing ( -- )
    FALSE { found }
    \ find dups
    nums_size 1+ 1 ?DO
        I count_nums 1 > IF
            I .
            TRUE TO found
        THEN
    LOOP
    \ find missing
    nums_size 1+ 1 ?DO
        I count_nums 0= IF
            I .
            TRUE TO found
        THEN
    LOOP
    \ print missing
    found 0= IF -1 . THEN
    CR
;

collect_args
print_dups_missing
BYE
