#! /usr/bin/env gforth

\ Perl Weekly Challenge 243 - Task 1 - solution by Paulo Custodio
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

: count_reverse_pairs ( -- n )
    0 { count }
    nums_size 1- 0 DO
        nums_size I 1+ DO
            J nums[] @  I nums[] @ 2* > IF
                count 1+ TO count
            THEN
        LOOP
    LOOP
    count
;

\ main
collect_args
count_reverse_pairs . CR
BYE
