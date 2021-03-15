#! /usr/bin/env gforth

\ Challenge 003
\
\ Challenge #2
\ Create a script that generates Pascal Triangle. Accept number of rows from
\ the command line. The Pascal Triangle should have at least 3 rows. For more
\ information about Pascal Triangle, check this wikipedia page.

100 CONSTANT MAX_ROWS

\ array to hold current and next row
CREATE data  MAX_ROWS 2* CELLS ALLOT

\ toggle for current row and function to compute next row
0 VALUE cur                         \ 0/1 of current data
: nxt 1 cur - ;                     \ 1/0 of next data
: toggle  1 cur - TO cur ;          \ toggle current

\ index current and next arrays
: data[]    ( index cur -- addr )
    SWAP CELLS SWAP                 ( index*cells cur )
    MAX_ROWS CELLS * +              ( index*cells cur*max_rows )
    data +
;

: cur[]     ( index -- addr )       cur data[] ;
: nxt[]     ( index -- addr )       nxt data[] ;


: print_row     ( rows row -- )
    2DUP - SPACES
    NIP         ( row )
    0 ?DO
        I cur[] @ .
    LOOP
    CR
;

: next_row      ( row -- )
    1 0 nxt[] !
    1 OVER nxt[] !
    1 ?DO
        I 1- cur[] @  i cur[] @  +
        I nxt[] !
    LOOP
    toggle
;

: draw_pascal       ( rows )
    1 0 cur[] !
    DUP 1+ 1 ?DO
        DUP I print_row
        I next_row
    LOOP
    DROP
;


\ get command line argument, call draw_pascal
NEXT-ARG S>NUMBER? 0= THROW DROP
draw_pascal
BYE
