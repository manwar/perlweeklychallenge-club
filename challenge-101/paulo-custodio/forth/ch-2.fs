#! /usr/bin/env gforth

\ Challenge 101
\
\ TASK #2 › Origin-containing Triangle
\ Submitted by: Stuart Little
\ You are given three points in the plane, as a list of six co-ordinates:
\ A=(x1,y1), B=(x2,y2) and C=(x3,y3).
\
\ Write a script to find out if the triangle formed by the given three
\ co-ordinates contain origin (0,0).
\
\ Print 1 if found otherwise 0.

: sign      { x1 y1 x2 y2 x3 y3 -- s }
    x1 x3 -  y2 y3 - *
    x2 x3 -  y1 y3 - *  - ;

: point_in_triangle     { xp yp x1 y1 x2 y2 x3 y3 -- f }
    0 0 0 { d1 d2 d3 }
    xp yp  x1 y1  x2 y2  sign TO d1
    xp yp  x2 y2  x3 y3  sign TO d2
    xp yp  x3 y3  x1 y1  sign TO d3

    0 0 { has-neg has-pos }
    d1 0<  d2 0<  d3 0<  OR OR TO has-neg
    d1 0>  d2 0>  d3 0>  OR OR TO has-pos

    has-neg has-pos AND 0= ;

\ collect coords
: get-num   ( -- n )
    NEXT-ARG DUP 0= THROW S>NUMBER? 0= THROW DROP ;


get-num VALUE x1
get-num VALUE y1
get-num VALUE x2
get-num VALUE y2
get-num VALUE x3
get-num VALUE y3

0 0 x1 y1 x2 y2 x3 y3 point_in_triangle 1 AND . CR
BYE
