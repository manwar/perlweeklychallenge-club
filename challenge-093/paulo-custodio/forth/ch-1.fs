#! /usr/bin/env gforth

\ Challenge 093
\
\ TASK #1 › Max Points
\ Submitted by: Mohammad S Anwar
\ You are given set of co-ordinates @N.
\
\ Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.
\
\ Example 1:
\ |
\ |     x
\ |   x
\ | x
\ + _ _ _ _
\
\ Input: (1,1), (2,2), (3,3)
\ Output: 3
\ Example 2:
\ |
\ |
\ | x       x
\ |   x
\ | x   x
\ + _ _ _ _ _
\
\ Input: (1,1), (2,2), (3,1), (1,3), (5,3)
\ Output: 3

\ Create array of points from command line arguments
0 VALUE num_points

: ,args         ( -- )
    BEGIN NEXT-ARG DUP WHILE
        S>NUMBER? 0= THROW DROP ,           \ convert x, drop high word, store
        NEXT-ARG DUP 0= THROW
        S>NUMBER? 0= THROW DROP ,           \ same for y
        num_points 1+ TO num_points
    REPEAT
    2DROP                                   \ drop result of next-arg
;

CREATE points ,args

\ index into points array
: x[]       ( index -- x-value-addr )
    CELLS 2* points +
;

: y[]       ( index -- x-value-addr )
    x[] 1 CELLS +
;

\ check if a point is in a line through two other points
\ compute cross product
: point_in_line     { ix iy jx jy kx ky -- f )
    kx ix -     ( dxc )
    jy iy -     ( dxc dyl )
    *           ( dxc*dyl )
    ky iy -     ( dxc*dyl dyc )
    jx ix -     ( dxc*dyl dyc dxl )
    *           ( dxc*dyl dyc*dxl )
    -           ( cross=dxc*dyl-dyc*dxl )
    0=
;

: points_in_line    { ix iy jx jy -- count }
    0                                       \ init to 0
    num_points 0 ?DO
        ix iy jx jy I x[] @ I y[] @
        point_in_line IF 1+ THEN            \ accumulate point in line
    LOOP
;

: max_in_line   ( -- n )
    0                                       \ init max to 0
    num_points 1- 0 ?DO                     \ 0 .. num_points-2
        num_points I 1+ ?DO                 \ i .. num_points-1
            J x[] @ J y[] @                 \ get ix, iy
            I x[] @ I y[] @                 \ get jx, jy
            points_in_line                  ( max current )
            MAX
        LOOP
    LOOP
;

max_in_line . CR
BYE
