#! /usr/bin/env gforth

\ Challenge 204
\
\ Task 2: Reshape Matrix
\ Submitted by: Mohammad S Anwar
\
\ You are given a matrix (m x n) and two integers (r) and (c).
\
\ Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.
\
\ Example 1
\
\ Input: [ 1 2 ]
\        [ 3 4 ]
\
\        $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
\        $r = 1
\        $c = 4
\
\ Output: [ 1 2 3 4 ]
\
\ Example 2
\
\ Input: [ 1 2 3 ]
\        [ 4 5 6 ]
\
\        $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
\        $r = 3
\        $c = 2
\
\ Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
\
\         [ 1 2 ]
\         [ 3 4 ]
\         [ 5 6 ]
\
\ Example 3
\
\ Input: [ 1 2 ]
\
\        $matrix = [ [ 1, 2 ] ]
\        $r = 3
\        $c = 2
\
\ Output: 0

\ array of numbers, setup by collect-args
CREATE items 256 CELLS ALLOT
0 VALUE num_items                   \ number of elements

: items[] ( i -- addr )
    CELLS items +
;

: push_item ( n -- )
    num_items items[] !
    num_items 1+ TO num_items
;

0 VALUE out_rows
0 VALUE out_cols

\ scanner
1024 CONSTANT max_line
CREATE line  max_line ALLOT
line VALUE line_ptr
0 VALUE line_len
9 CONSTANT TAB
0 CONSTANT EOL

\ read next line, return false on eof
: read_line ( -- ok )
    line TO line_ptr
    line max_line stdin READ-LINE THROW     ( len flag )
    SWAP
    DUP TO line_len
    line + EOL SWAP C!                      \ store end marker
;

\ get current char, 0 at end of line
: cur_char ( -- ch )
    line_ptr C@
;

\ next non-blank char, 0 at end of line
: next_char ( -- ch )
    0 { ch }
    BEGIN
        cur_char TO ch
        ch EOL = IF EXIT THEN
        ch BL =  ch TAB =  OR
    WHILE
        line_ptr 1+ TO line_ptr
    REPEAT
    ch
;

: parse_char { ch -- ok }
    next_char ch = IF
        line_ptr 1+ TO line_ptr
        TRUE
    ELSE
        FALSE
    THEN
;

: parse_number ( -- n true | 0 false )
    next_char DUP '0' >= SWAP '9' <= AND IF
        0 0 line_ptr  line_len  line_ptr line - -   ( 0. addr len )
        >NUMBER DROP TO line_ptr
        DROP TRUE
    ELSE
        0 0
    THEN
;


\ parse input
: parse_matrix_line ( -- ok )
    '[' parse_char IF
        BEGIN parse_number WHILE
            push_item
        REPEAT
        DROP
        ']' parse_char DROP
        TRUE
    ELSE
        FALSE
    THEN
;

: parse_matrix ( -- )
    BEGIN read_line WHILE
        parse_matrix_line 0= IF EXIT THEN
    REPEAT
;

: parse_input ( -- )
    parse_matrix
    parse_number DROP TO out_rows
    parse_number DROP TO out_cols
;


\ print output
: output_matrix ( -- )
    out_rows out_cols *  num_items = IF
        out_rows 0 DO
            '[' EMIT
            out_cols 0 DO
                J out_cols * I + items[] @ .
            LOOP
            ']' EMIT CR
        LOOP
    ELSE
        0 . CR
    THEN
;


parse_input output_matrix
BYE
