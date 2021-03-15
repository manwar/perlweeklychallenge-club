#! /usr/bin/env gforth

\ Challenge 001
\
\ Challenge #2
\ Write a one-liner to solve the FizzBuzz problem and print the numbers 1 through 20. However, any number divisible by 3 should be replaced by the word ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both divisible by 3 and 5 become ‘fizzbuzz’.

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
