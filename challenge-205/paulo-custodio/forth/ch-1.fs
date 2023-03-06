#! /usr/bin/env gforth

\ Challenge 205
\
\ Task 1: Third Highest
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to find out the Third Highest if found otherwise return the maximum.
\ Example 1
\
\ Input: @array = (5,3,4)
\ Output: 3
\
\ First highest is 5. Second highest is 4. Third highest is 3.
\
\ Example 2
\
\ Input: @array = (5,6)
\ Output: 6
\
\ First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
\
\ Example 3
\
\ Input: @array = (5,4,4,3)
\ Output: 3
\
\ First highest is 5. Second highest is 4. Third highest is 3.


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


\ reverse sort array of integers
: rsort ( -- )
    num_items 0> IF
        num_items 1- 0 ?DO
            num_items I 1+ ?DO
                J items[] @
                I items[] @
                < IF
                    J items[] @ I items[] @ J items[] ! I items[] !
                THEN
            LOOP
        LOOP
    THEN
;


\ remove duplicate items from list
: uniq ( -- )
    items @ 1+ { last }         \ create last different from first
    0 { write }
    num_items 0 ?DO
        I items[] @  DUP last <> IF
            DUP write items[] !
            TO last
            write 1+ TO write
        ELSE
            DROP
        THEN
    LOOP
    write TO num_items
;


\ return third highest
: task ( -- n )
    collect_args rsort uniq
    num_items DUP 0= IF
        DROP 0
    ELSE DUP 3 < IF
        DROP 0 items[] @
    ELSE
        DROP 2 items[] @
    THEN THEN
;


task . CR
BYE
