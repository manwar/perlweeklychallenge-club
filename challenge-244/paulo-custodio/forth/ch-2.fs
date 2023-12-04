#! /usr/bin/env gforth

\ Challenge 244
\
\ Task 2: Group Hero
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers representing the strength.
\
\ Write a script to return the sum of the powers of all possible combinations;
\ power is defined as the square of the largest number in a sequence, multiplied
\ by the smallest.
\
\ Example 1
\
\ Input: @nums = (2, 1, 4)
\ Output: 141
\
\ Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
\ Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
\ Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
\ Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
\ Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
\ Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
\ Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
\
\ Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

CREATE nums     256 CELLS ALLOT
CREATE counters 256 CELLS ALLOT
CREATE combo    256 CELLS ALLOT

: array_size ( arr-addr -- size-addr )
;

: array_clear ( arr-addr -- )
    0 SWAP array_size !
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

: array_min ( arr -- n )
    { arr }
    arr 0 array[] @     ( min )
    arr array_size @ 0 ?DO
        arr I array[] @  MIN
    LOOP
;

: array_max ( arr -- n )
    { arr }
    arr 0 array[] @     ( min )
    arr array_size @ 0 ?DO
        arr I array[] @  MAX
    LOOP
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

: counters_init ( k -- )
    counters array_clear
    0 ?DO
        counters 0 array_push_back
    LOOP
;

: counters_increment ( -- f )   \ return false when wrapping arround
    counters array_size @ 1- { i }
    BEGIN i 0 >= WHILE
        counters i array[] 1 SWAP +!
        counters i array[] @  nums array_size @  < IF TRUE EXIT THEN
        0 counters i array[] !
        i 1- TO i
    REPEAT
    FALSE
;

: counters_unique ( -- f )      \ return true if counters are all different and increasing
    TRUE
    counters array_size @ 1 ?DO
        counters I array[] @
        counters I 1- array[] @
        <= IF DROP FALSE LEAVE THEN
    LOOP
;

: counters_select ( -- )
    combo array_clear
    counters array_size @ 0 ?DO
        counters I array[] @
        nums SWAP array[] @
        combo SWAP array_push_back
    LOOP
;

: array_calc_power ( arr - n )
    { arr }
    arr array_max DUP *
    arr array_min *
;

: calc_power_k ( k -- n )
    counters_init
    0           ( power )
    BEGIN
        counters_unique IF
            counters_select combo array_calc_power +
        THEN
        counters_increment 0= IF EXIT THEN
    AGAIN
;

: calc_power ( -- n )
    0           ( power )
    nums array_size @ 1+ 1 ?DO
        I calc_power_k +
    LOOP
;

collect_args
calc_power . CR
BYE
