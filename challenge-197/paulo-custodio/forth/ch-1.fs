#! /usr/bin/env gforth

\ Challenge 197
\
\ Task 1: Move Zero
\ Submitted by: Mohammad S Anwar
\ You are given a list of integers, @list.
\
\ Write a script to move all zero, if exists, to the end while maintaining
\ the relative order of non-zero elements.
\
\
\ Example 1
\ Input:  @list = (1, 0, 3, 0, 0, 5)
\ Output: (1, 3, 5, 0, 0, 0)
\ Example 2
\ Input: @list = (1, 6, 4)
\ Output: (1, 6, 4)
\ Example 3
\ Input: @list = (0, 1, 0, 2, 0)
\ Output: (1, 2, 0, 0, 0)

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( idx -- addr )
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

: print_nums ( -- )
    nums_size 0 ?DO
        I nums[] @ .
    LOOP
    CR
;

: move_zeros ( -- )
    nums_size 1 > IF
        nums_size { p }         \ copy to end of list
        \ copy non-zero elements
        nums_size 0 DO
            I nums[] @ DUP 0<> IF
                p nums[] !
                p 1+ TO p
            ELSE
                DROP
            THEN
        LOOP
        \ copy zero elements
        nums_size 0 DO
            I nums[] @ DUP 0= IF
                p nums[] !
                p 1+ TO p
            ELSE
                DROP
            THEN
        LOOP
        \ move back to start of nums
        nums_size nums[]  0 nums[]  nums_size CELLS  MOVE
    THEN
;

collect_args
move_zeros
print_nums
BYE
