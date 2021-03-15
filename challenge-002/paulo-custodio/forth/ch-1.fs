#! /usr/bin/env gforth

\ Challenge 002
\
\ Challenge #1
\ Write a script or one-liner to remove leading zeros from positive numbers.

: remove_leading_zeros      ( str len -- str len )
    DUP 0> IF
        BEGIN
            DUP 1 >             \ len > 0
            2 PICK C@ '0' =     \ starts with zero
        AND WHILE
            1 /STRING           \ remove character of string
        REPEAT
    THEN
;

NEXT-ARG remove_leading_zeros TYPE CR BYE
