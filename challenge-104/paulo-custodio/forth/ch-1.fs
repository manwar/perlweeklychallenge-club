#! /usr/bin/env gforth

\ Challenge 104
\
\ TASK #1 › FUSC Sequence
\ Submitted by: Mohammad S Anwar
\ Write a script to generate first 50 members of FUSC Sequence. Please refer to
\ OEIS for more information.
\
\ The sequence defined as below:
\
\ fusc(0) = 0
\ fusc(1) = 1
\ for n > 1:
\ when n is even: fusc(n) = fusc(n / 2),
\ when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

: fusc  { n -- n }
    n 0=  IF 0 EXIT THEN
    n 1 = IF 1 EXIT THEN
    n 1 AND 0= IF       \ even
        n 2/ RECURSE
    ELSE
        n 1- 2/ RECURSE
        n 1+ 2/ RECURSE +
    THEN
;

: n-fusc    ( n -- )
    0 ?DO
        I FUSC .
    LOOP
    CR
;

NEXT-ARG S>NUMBER? 0= THROW DROP
n-fusc
BYE
