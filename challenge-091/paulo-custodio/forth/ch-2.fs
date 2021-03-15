\ THE WEEKLY CHALLENGE - 091
\ TASK #2: Jump Game
\
\ You are given an array of positive numbers @N, where value at each index
\ determines how far you are allowed to jump further. Write a script to decide
\ if you can jump to the last index. Print 1 if you are able to reach the last
\ index otherwise 0.

\ Start the script with the table and its size on the stack, e.g.
\   gforth -e '1 2 1 2  4' ch-2.fs

\ setup: tbl tbl-size
VALUE tbl-size      \ save table size
: ,values
    tbl-size 0 DO
        tbl-size I - 1- ROLL ,
    LOOP
;

CREATE tbl ,values

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
