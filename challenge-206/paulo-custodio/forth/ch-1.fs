#! /usr/bin/env gforth

\ Challenge 206
\
\ Task 1: Shortest Time
\ Submitted by: Mohammad S Anwar
\
\ You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
\
\ Write a script to find out the shortest time in minutes between any two time points.
\ Example 1
\
\ Input: @time = ("00:00", "23:55", "20:00")
\ Output: 5
\
\ Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
\
\ Example 2
\
\ Input: @array = ("01:01", "00:50", "00:57")
\ Output: 4
\
\ Example 3
\
\ Input: @array = ("10:10", "09:30", "09:00", "09:55")
\ Output: 15


\ convert hh:mm into minutes, return 0 if parse error
: parse-minutes ( str len -- minutes )
    0 0 2SWAP                       ( 0. str len )
    >NUMBER                         ( hours. str len )
    2SWAP SWAP 60 * SWAP 2SWAP
    OVER C@ ':' <> IF
        2DROP 2DROP 0               ( 0 )
    ELSE
        SWAP 1+ SWAP 1-             ( hours*60. str+1 len-1 )
        0 0 2SWAP                   ( hours*60. 0. str+1 len-1 )
        >NUMBER                     ( minutes. str len )
        DUP 0<> IF
            2DROP 2DROP 2DROP 0     ( 0 )
        ELSE
            2DROP D+ DROP           ( minutes )
        THEN
    THEN
;

\ array of minutes, setup by collect-args
0 VALUE items                       \ array of minutes
0 VALUE num_items                   \ number of elements

: items[] ( i -- addr )
    CELLS items +
;

\ collect arguments from input, convert to minutes and store in items
: collect-args ( -- )
    HERE TO items
    BEGIN NEXT-ARG DUP WHILE        \ while argments
        parse-minutes ,
    REPEAT
    2DROP
    25 60 * ,                       \ add placeholder for end element
    HERE items - 1 CELLS / TO num_items
;


\ sort array of integers
: sort { addr num -- }
    num 1- 0 DO
        num I 1+ DO
            J items[] @
            I items[] @
            > IF
                J items[] @ I items[] @ J items[] ! I items[] !
            THEN
        LOOP
    LOOP
;


\ setup sorted input data with last element = first + 24 hours
: setup-data ( -- )
    collect-args
    items num_items sort
    0 items[] @ 24 60 * + num_items 1- items[] !
;


\ compute minimum interval
: compute-minimum-interval ( -- minutes )
    24 60 *                         ( min )
    num_items 1- 0 DO
        num_items I 1+ DO
            I items[] @
            J items[] @
            -
            MIN
        LOOP
    LOOP
;

setup-data compute-minimum-interval . CR
BYE
