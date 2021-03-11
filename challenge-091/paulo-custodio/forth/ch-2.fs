#! /usr/bin/env gforth

\ Challenge 091
\
\ TASK #2: Jump Game
\
\ You are given an array of positive numbers @N, where value at each index
\ determines how far you are allowed to jump further. Write a script to decide
\ if you can jump to the last index. Print 1 if you are able to reach the last
\ index otherwise 0.


0 VALUE tbl-size      \ save table size

\ collect_args, append them to heap
: collect_args  ( -- )
    0 TO tbl-size
    BEGIN NEXT-ARG DUP 0> WHILE
        S>NUMBER? 0= THROW DROP ,
        tbl-size 1+ TO tbl-size
    REPEAT
;

CREATE tbl
collect_args

\ run the table
: run ( -- f )
    0           ( pos )
    BEGIN
        DUP tbl-size 1- = IF    \ pos = tbl-size - 1
            DROP 1 EXIT         \ found end
        ELSE
            DUP tbl-size 1- > IF \ pos > tbl-size - 1
                DROP 0 EXIT     \ behond end
            THEN
        THEN
        DUP CELLS tbl + @       ( pos tbl[pos] )
        DUP 0= IF               \ tbl[pos] = 0
            DROP 0 EXIT         \ no solution
        THEN
        +
    AGAIN
;

run . CR BYE
