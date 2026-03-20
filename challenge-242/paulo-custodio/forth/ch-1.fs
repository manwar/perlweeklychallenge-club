#! /usr/bin/env gforth

\ Perl Weekly Challenge 242 - Task 1 - solution by Paulo Custodio
\ https://theweeklychallenge.org/blog/perl-weekly-challenge-242/

CREATE arr1 256 CELLS ALLOT
CREATE arr2 256 CELLS ALLOT

: .nospace ( n -- )
  DUP S>D <# #S ROT SIGN #> TYPE
;

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

: array_find ( arr-addr n -- f )
    { arr n }
    FALSE { found }
    arr array_size @ 0 ?DO
        arr I array[] @  n = IF TRUE TO found LEAVE THEN
    LOOP
    found
;

: array_push_back_if_new ( arr-add n -- )
    { arr n }
    arr n array_find 0= IF
        arr n array_push_back
    THEN
;

: is_digit ( c -- f )
    DUP '0' >= SWAP '9' <= AND
;

: starts_with_digit ( addr len -- f )
    0 > SWAP C@ is_digit AND
;

: skip_non_digits ( addr len -- addr len )
    BEGIN DUP WHILE
        2DUP starts_with_digit IF EXIT THEN
        1 /STRING
    REPEAT
;

: parse_number ( addr len -- addr len number t | addr len f )
    0 { num }
    skip_non_digits
    2DUP starts_with_digit IF
        BEGIN 2DUP starts_with_digit WHILE
            OVER C@ '0' -  num BASE *  + TO num
            1 /STRING
        REPEAT
        num TRUE
    ELSE
        FALSE
    THEN
;

: array_parse_nums ( arr-add str-addr size -- )
    { arr str len }
    BEGIN str len parse_number WHILE
        arr SWAP array_push_back_if_new
        TO len TO str
    REPEAT
    2DROP
;

: collect_args ( -- )
    arr1 NEXT-ARG array_parse_nums
    arr2 NEXT-ARG array_parse_nums
;

: print_missing ( arr1 arr2 is-first -- )
    { arr1 arr2 is-first }
    FALSE { found }
    arr1 array_size @ 0 ?DO
        arr1 I array[] @
        arr2 SWAP array_find 0= IF
            found 0= IF
                is-first 0= IF ." , " THEN
                ." ["
            ELSE
                ." , "
            THEN
            TRUE TO found
            arr1 I array[] @ .nospace
        THEN
    LOOP
    found IF ." ]" THEN
;

: output ( -- )
    ." ("
    arr1 arr2 TRUE  print_missing
    arr2 arr1 FALSE print_missing
    ." )" CR
;

collect_args
output
BYE
