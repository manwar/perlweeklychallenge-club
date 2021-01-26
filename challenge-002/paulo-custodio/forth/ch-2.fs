#! /usr/bin/env gforth

\ Challenge 002
\
\ Challenge #2
\ Write a script that can convert integers to and from a base35
\ representation, using the characters 0-9 and A-Y. Dave Jacoby came up
\ with nice description about base35, in case you needed some background.

\ get argument, parse -r
0 VALUE opt_r
: parse_args    ( str len -- )
    NEXT-ARG
    2DUP s" -r" COMPARE 0= IF   \ option -r
        -1 TO opt_r             \ reverse option
        2DROP NEXT-ARG          \ read next argument
    THEN
;

: convertb35    ( str len -- )
    opt_r IF                    \ parse base 35
        35 BASE ! S>NUMBER? DECIMAL 0= THROW DROP
        .
    ELSE
        S>NUMBER? 0= THROW DROP
        35 BASE ! . DECIMAL
    THEN
;

parse_args convertb35 CR BYE
