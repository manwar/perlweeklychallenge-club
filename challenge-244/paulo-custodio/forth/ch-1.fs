#! /usr/bin/env gforth

\ Perl Weekly Challenge 244 - Task 1 - solution by Paulo Custodio
\ https://theweeklychallenge.org/blog/perl-weekly-challenge-244/

CREATE nums     256 CELLS ALLOT
CREATE smaller  256 CELLS ALLOT

: array_size ( arr-addr -- size-addr )
;

: array[] ( arr-addr i -- elem-addr )
    1+ CELLS +
;

: array_push_back ( arr-addr n -- )
    { arr n }
    arr array_size @    ( size )
    arr SWAP array[]    ( elem-addr )
    n SWAP !
    arr array_size 1 SWAP +!
;

: .array ( arr -- )
    { arr }
    arr array_size @ 0 ?DO
        arr I array[] @ .
    LOOP
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        nums SWAP array_push_back
    REPEAT
    2DROP
;

: compute_smaller ( -- )
    nums array_size @ 0 ?DO
        0           ( count )
        nums array_size @ 0 ?DO
            nums I array[] @  nums J array[] @  <  IF 1+ THEN
        LOOP
        smaller SWAP array_push_back
    LOOP
;

collect_args
compute_smaller
smaller .array
BYE
