#! /usr/bin/env gforth

\ Challenge 242
\
\ Task 2: Flip Matrix
\ Submitted by: Mohammad S Anwar
\ You are given n x n binary matrix.
\
\ Write a script to flip the given matrix as below.
\
\ 1 1 0
\ 0 1 1
\ 0 0 1
\
\ a) Reverse each row
\
\ 0 1 1
\ 1 1 0
\ 1 0 0
\
\ b) Invert each member
\
\ 1 0 0
\ 0 0 1
\ 0 1 1
\
\ Example 1
\ Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
\ Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
\ Example 2
\ Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
\ Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

CREATE nums 256 CELLS ALLOT

: matrix_size ( arr -- addr ) ;
: matrix[][] { arr r c -- addr }  arr matrix_size @ r * c + 1+ CELLS arr + ;
: matrix_push_back_row0 { arr n -- }
    arr matrix_size @               ( size )
    arr SWAP 0 SWAP matrix[][]      ( elem-addr )
    n SWAP !
    arr matrix_size 1 SWAP +!
;

: is_digit ( c -- f )
    DUP '0' >= SWAP '9' <= AND
;

: is_end_row ( addr len -- f )
    1 > SWAP DUP C@ ']' = SWAP 1+ C@ ',' = AND AND
;

: starts_with_digit ( addr len -- f )
    0 > SWAP C@ is_digit AND
;

: skip_non_digits ( addr len -- addr len )
    BEGIN DUP WHILE
        2DUP starts_with_digit >R
        2DUP is_end_row R> OR IF EXIT THEN
        1 /STRING
    REPEAT
;

: parse_number ( addr len -- addr len number t | addr len f )
    0 { num }
    skip_non_digits
    2DUP starts_with_digit IF
        BEGIN 2DUP starts_with_digit WHILE
            OVER C@ '0' -  num BASE *  + TO num
            1 /STRING
        REPEAT
        num TRUE
    ELSE
        FALSE
    THEN
;

: parse_row0 { arr addr len -- addr len }
    BEGIN addr len parse_number WHILE
        arr SWAP matrix_push_back_row0
        TO len TO addr
    REPEAT
    TO len TO addr
    addr len
;

: parse_matrix { arr addr len -- }
    arr addr len parse_row0 TO len TO addr
    arr matrix_size @ { size }
    size 1 ?DO ( rows )
        addr len is_end_row IF
            addr len 1 /STRING TO len TO addr
        THEN
        size 0 ?DO ( cols )
            addr len parse_number IF
                arr J I matrix[][] !
            THEN
            TO len TO addr
        LOOP
    LOOP
;

: reverse_row { addr len -- }
    len 0 ?DO
        addr I CELLS + @
    LOOP
    len 0 ?DO
        addr I CELLS + !
    LOOP
;

: reverse_rows { arr -- }
    arr matrix_size @ { len }
    len 0 ?DO
        arr I 0 matrix[][] len reverse_row
    LOOP
;

: invert_members { arr -- }
    arr matrix_size @ { len }
    len 0 ?DO
        len 0 ?DO
            arr J I matrix[][] @
            1 XOR
            arr J I matrix[][] !
        LOOP
    LOOP
;

: output  { arr -- }
    arr matrix_size @ { len }
    '(' EMIT
    len 0 ?DO
        '[' EMIT
        len 0 ?DO
            arr J I matrix[][] @ 0 U.R
            I len 1- <> IF ." , " THEN
        LOOP
        ']' EMIT
        I len 1- <> IF ." , " THEN
    LOOP
    ')' EMIT CR
;

nums NEXT-ARG parse_matrix
nums reverse_rows
nums invert_members
nums output
BYE
