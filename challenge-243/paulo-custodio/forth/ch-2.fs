#! /usr/bin/env gforth

\ Perl Weekly Challenge 243 - Task 2 - solution by Paulo Custodio
\ https://theweeklychallenge.org/blog/perl-weekly-challenge-243/

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( i -- addr )
    CELLS nums +
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        nums_size nums[] !
        nums_size 1+ TO nums_size
    REPEAT
    2DROP
;

: sum_floor ( -- n )
    0 { sum }
    nums_size 0 DO
        nums_size 0 DO
            sum  J nums[] @  I nums[] @  /  +  TO sum
        LOOP
    LOOP
    sum
;

\ main
collect_args
sum_floor . CR
BYE
