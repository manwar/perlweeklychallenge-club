#! /usr/bin/env gforth

\ Challenge 100
\
\ TASK #1 > Fun Time
\ Submitted by: Mohammad S Anwar
\ You are given a time (12 hour / 24 hour).
\
\ Write a script to convert the given time from 12 hour format to 24 hour format and vice versa.
\
\ Ideally we expect a one-liner.
\
\ Example 1:
\ Input: 05:15 pm or 05:15pm
\ Output: 17:15
\ Example 2:
\ Input: 19:15
\ Output: 07:15 pm or 07:15pm

\ skip blanks
: skip-blanks       ( str len -- str len )
    BEGIN
        DUP 0= IF EXIT THEN                             \ string empty
        OVER C@ BL <> IF EXIT THEN                      \ not space
        1 /STRING
    AGAIN
;

\ parse a time string, return number of minutes since midnight
\ and true if it was in AM/PM format
: parse-time        { str len -- hours minutes f-am-pm }
    0 0 { hours minutes }
    0 0 str len >NUMBER TO len TO str DROP TO hours     \ convert hours
    str C@ ':' <> IF 1 THROW THEN
    str len 1 /STRING TO len TO str                     \ skip ':'
    0 0 str len >NUMBER TO len TO str DROP TO minutes   \ convert minutes
    str len skip-blanks TO len TO str                   \ spaces
    len 0= IF
        hours minutes FALSE
    ELSE str C@ DUP 'a' = SWAP 'A' = OR IF              \ AM
        hours 12 = IF 0 TO hours THEN
        hours minutes TRUE
    ELSE str C@ DUP 'p' = SWAP 'P' = OR IF              \ PM
        hours 12 <> IF hours 12 + TO hours THEN
        hours minutes TRUE
    THEN THEN THEN
;

\ output in 24-hour format
: print24       ( hours minutes -- )
    SWAP 100 * + 0                  \ convert to hhmm in decimal, double
    <# # # ':' HOLD # # #> TYPE
;

\ output in 12-hour format
: print12       { hours minutes -- }
    FALSE { pm }                    \ assume AM

    hours DUP 12 > IF
        DROP hours 12 - TO hours TRUE TO pm ELSE
    DUP 12 = IF
        DROP TRUE TO pm ELSE
    DUP 0= IF
        DROP 12 TO HOURS
    ELSE DROP THEN THEN THEN

    hours minutes print24
    pm IF ." pm" ELSE ." am" THEN
;

\ convert time
: convert-time      ( str len -- )
    parse-time IF print24 ELSE print12 THEN
;

\ main
NEXT-ARG convert-time CR BYE
