#! /usr/bin/env gforth

\ Challenge 197
\
\ Task 2: Wiggle Sort
\ Submitted by: Mohammad S Anwar
\ You are given a list of integers, @list.
\
\ Write a script to perform Wiggle Sort on the given list.
\
\
\ Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….
\
\
\ Example 1
\ Input: @list = (1,5,1,1,6,4)
\ Output: (1,6,1,5,1,4)
\ Example 2
\ Input: @list = (1,3,2,2,3,1)
\ Output: (2,3,1,3,1,2)

CREATE nums 256 CELLS ALLOT
CREATE copy 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( i -- addr )
    CELLS nums +
;

: copy[] ( i -- addr )
    CELLS copy +
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

: sort ( -- )
    nums_size 1 > IF
        nums_size 1- 0 ?DO
            nums_size I 1+ ?DO
                J nums[] @  I nums[] @  >  IF
                    J nums[] @  I nums[] @
                    J nums[] !  I nums[] !
                THEN
            LOOP
        LOOP
    THEN
;

: copy_data { src dst -- }
    BEGIN dst 0>= WHILE
        src copy[] @  dst nums[] !
        src 1+ TO src
        dst 2 - TO dst
    REPEAT
;

: copy_nums ( -- )
    sort  nums copy nums_size CELLS MOVE
;

: wiggle_sort ( -- )
    nums_size 1 > IF
        copy_nums
        0  nums_size 2 -  copy_data
        nums_size 2 /  nums_size 1- copy_data
    THEN
;

collect_args
wiggle_sort
print_nums
BYE
