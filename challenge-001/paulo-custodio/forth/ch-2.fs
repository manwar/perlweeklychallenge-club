#! /usr/bin/env gforth

\ Perl Weekly Challenge 001 - Task 2 - solution by Paulo Custodio
\ https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

: fizzbuzz  ( n -- )
    1+ 1 ?DO
        I 15 MOD 0= IF ." fizzbuzz" ELSE
        I  3 MOD 0= IF ." fizz" ELSE
        I  5 MOD 0= IF ." buzz" ELSE I .
        THEN THEN THEN
        CR
    LOOP
;

20 fizzbuzz
BYE
