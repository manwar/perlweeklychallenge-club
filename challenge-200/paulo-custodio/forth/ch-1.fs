#! /usr/bin/env gforth

\ Challenge 200
\
\ Task 1: Arithmetic Slices
\ Submitted by: Mohammad S Anwar
\ You are given an array of integers.
\
\ Write a script to find out all Arithmetic Slices for the given array of integers.
\
\ An integer array is called arithmetic if it has at least 3 elements and the
\ differences between any three consecutive elements are the same.
\
\
\ Example 1
\ Input: @array = (1,2,3,4)
\ Output: (1,2,3), (2,3,4), (1,2,3,4)
\ Example 2
\ Input: @array = (2)
\ Output: () as no slice found.

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

: is_arithmetic { idx num -- f }
    idx 1+ nums[] @  idx nums[] @  -  { step }
    TRUE                    ( f )
    num 1 DO
        idx I + nums[] @  idx I + 1- nums[] @  -  step <> IF
            DROP FALSE LEAVE
        THEN
    LOOP
;

: print_slices ( -- )
    FALSE { sep }

    ." ("
    nums_size 2 > IF
        nums_size 2 -  0  DO
            nums_size  I 2 +  DO
                J  I J - 1+  is_arithmetic  IF
                    sep IF ." ), (" THEN  TRUE TO sep
                    I 1+  J  DO
                        I nums[] @ .
                        I J <> IF ." ," THEN
                    LOOP
                THEN
            LOOP
        LOOP
    THEN
    ." )" CR
;


collect_args print_slices BYE
