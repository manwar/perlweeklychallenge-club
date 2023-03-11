#! /usr/bin/env gforth

\ Challenge 201
\
\ Task 1: Missing Numbers
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of unique numbers.
\
\ Write a script to find out all missing numbers in the range 0..$n where $n
\ is the array size.
\
\ Example 1
\
\ Input: @array = (0,1,3)
\ Output: 2
\
\ The array size i.e. total element count is 3, so the range is 0..3.
\ The missing number is 2 in the given array.
\
\ Example 2
\
\ Input: @array = (0,1)
\ Output: 2
\
\ The array size is 2, therefore the range is 0..2.
\ The missing number is 2.

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( i -- addr )
    CELLS nums +
;

: find_nums { n -- f }
    FALSE                   ( f )
    nums_size 0 DO
        I nums[] @ n = IF
            DROP TRUE LEAVE
        THEN
    LOOP
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        nums_size nums[] !
        nums_size 1+ TO nums_size
    REPEAT
    2DROP
;

: .missing ( -- )
    nums_size 1+ 0 DO
        I find_nums 0= IF I . THEN
    LOOP
    CR
;

collect_args .missing BYE
