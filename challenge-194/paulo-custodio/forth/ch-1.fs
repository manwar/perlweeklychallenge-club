#! /usr/bin/env gforth

\ Challenge 194
\
\ Task 1: Digital Clock
\ Submitted by: Mohammad S Anwar
\ You are given time in the format hh:mm with one missing digit.
\
\ Write a script to find the highest digit between 0-9 that makes it valid time.
\
\ Example 1
\ Input: $time = '?5:00'
\ Output: 1
\
\ Since 05:00 and 15:00 are valid time and no other digits can fit in the missing place.
\ Example 2
\ Input: $time = '?3:00'
\ Output: 2
\ Example 3
\ Input: $time = '1?:00'
\ Output: 9
\ Example 4
\ Input: $time = '2?:00'
\ Output: 3
\ Example 5
\ Input: $time = '12:?5'
\ Output: 5
\ Example 6
\ Input: $time =  '12:5?'
\ Output: 9

0 VALUE clock
: h1 ( -- d ) clock C@ ;
: h2 ( -- d ) clock 1+ C@ ;
: m1 ( -- d ) clock 3 + C@ ;
: m2 ( -- d ) clock 4 + C@ ;
: is_quest ( d -- f ) '?' = ;
: is_01 ( d -- f ) DUP '0' >= SWAP '1' <= AND ;
: is_03 ( d -- f ) DUP '0' >= SWAP '3' <= AND ;
: is_05 ( d -- f ) DUP '0' >= SWAP '5' <= AND ;
: is_2 ( d - f ) '2' = ;

: missing_digit ( addr len -- d )
    5 <>                            IF DROP -1 ELSE
        TO clock
        h1 is_quest h2 is_03 AND    IF 2 ELSE
        h1 is_quest                 IF 1 ELSE
        h1 is_01    h2 is_quest AND IF 9 ELSE
        h1 is_2     h2 is_quest AND IF 3 ELSE
        m1 is_quest                 IF 5 ELSE
        m1 is_05    m2 is_quest AND IF 9 ELSE -1
        THEN THEN THEN THEN THEN THEN
    THEN
;

NEXT-ARG missing_digit . CR
BYE
