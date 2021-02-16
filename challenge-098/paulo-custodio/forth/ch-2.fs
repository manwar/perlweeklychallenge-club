#! /usr/bin/env gforth

\ Challenge 098
\
\ TASK #2 › Search Insert Position
\ Submitted by: Mohammad S Anwar
\ You are given a sorted array of distinct integers @N and a target $N.
\
\ Write a script to return the index of the given target if found
\ otherwise place the target in the sorted array and return the index.
\
\ Example 1:
\ Input: @N = (1, 2, 3, 4) and $N = 3
\ Output: 2 since the target 3 is in the array at the index 2.
\ Example 2:
\ Input: @N = (1, 3, 5, 7) and $N = 6
\ Output: 3 since the target 6 is missing and should be placed at
\ the index 3.
\ Example 3:
\ Input: @N = (12, 14, 16, 18) and $N = 10
\ Output: 0 since the target 10 is missing and should be placed at
\ the index 0.
\ Example 4:
\ Input: @N = (11, 13, 15, 17) and $N = 19
\ Output: 4 since the target 19 is missing and should be placed at
\ the index 4.

\ output number without space
: .num              ( n -- )
    0 U.R
;

: str>number        ( str len -- n )
    S>NUMBER? 0= THROW DROP
;

: arg>number        ( -- n )
    NEXT-ARG str>number
;

\ list of numbers with max size and current size in first cell
: iarray.new        ( max-size -- ) \ creates a new word
    CREATE
    0 ,                             \ store size
    CELLS ALLOT                     \ allocate space
;

: iarray.size       ( arr -- size )
    @
;

: iarray.front      ( arr -- addr-of-first-elem )
    1 CELLS +
;

: iarray.back       ( arr -- addr-after-last-elem )
    DUP @ 1+ CELLS +
;

: iarray.push       { arr n -- }
    n arr iarray.back !
    1 arr +!
;

: iarray.elem       ( arr index -- addr )
    1+ CELLS +
;

: iarray.insert     { arr i n -- }
    arr i iarray.elem
    DUP
    DUP 1 CELLS +  arr iarray.size i - CELLS CMOVE>
    n SWAP !
    1 arr +!
;

: iarray.delete     { arr i -- }
    arr i iarray.elem
    DUP 1 CELLS + SWAP  arr iarray.size i - CELLS CMOVE
    -1 arr +!
;

: iarray.bsearch    { arr n -- i f-found}
    arr iarray.size 0= IF 0 FALSE EXIT THEN         \ array empty
    n  arr iarray.front @ < IF 0 FALSE EXIT THEN    \ before first
    n  arr iarray.back 1 CELLS - @ > IF             \ after last
        arr iarray.size FALSE EXIT
    THEN

    0                   { b }
    arr iarray.size     { t }
    0                   { m }
    BEGIN
        b t 1- <
    WHILE
        b t + 2 / TO m
        n  arr m iarray.elem @
        2DUP = IF 2DROP m TRUE EXIT ELSE        \ found
        < IF m TO t
        ELSE m TO b
        THEN THEN
    REPEAT
    t FALSE
;

: iarray.print      { arr -- }
    ." ("
    arr iarray.size 0 ?DO
        I 0> IF ." , " THEN
        arr I iarray.elem @ .num
    LOOP
    ." )"
;

100 iarray.new nums     \ array of numbers
0 VALUE n               \ number to find/insert

\ collect args
: collect-args      ( -- )
    arg>number TO n
    BEGIN
        NEXT-ARG DUP 0>
    WHILE
        str>number  nums SWAP iarray.push
    REPEAT 2DROP
;

\ search index and insert if not found
: search_index          ( -- i )
    nums n iarray.bsearch   { i f }
    f 0= IF     \ not found
        nums i n iarray.insert
    THEN
    i
;

collect-args
search_index .num CR
nums iarray.print CR
BYE
