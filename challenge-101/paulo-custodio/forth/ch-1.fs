#! /usr/bin/env gforth

\ Challenge 101
\
\ TASK #1 › Pack a Spiral
\ Submitted by: Stuart Little
\
\ You are given an array @A of items (integers say, but they can be anything).
\
\ Your task is to pack that array into an MxN matrix spirally counterclockwise,
\ as tightly as possible.
\
\ ‘Tightly’ means the absolute value |M-N| of the difference has to be as small
\ as possible.

VARIABLE #nums  0 #nums !           \ number of items
VARIABLE width  1 width !           \ max width of items

\ collect argumens, append them to dictionary
: collect-args      ( -- )
    BEGIN NEXT-ARG ?DUP WHILE
        DUP  width @  MAX  width !  \ get maximum width
        S>NUMBER? 0= THROW DROP     \ convert to number
        ,                           \ add to dictionary
        1 #nums +!                  \ count it
    REPEAT DROP ;

CREATE nums  collect-args

\ compute rows and cols
: smallest_rect { n -- rows cols }
    1 1 n { i low high }
    BEGIN low high < WHILE
        n i MOD 0= IF
            i       TO low
            n i /   TO high
        THEN
        i 1+ TO i
    REPEAT
    high low ;

VARIABLE #ROWS
VARIABLE #cols

#nums @  smallest_rect  #cols !  #ROWS !

\ create rectangle for spiral
CREATE rect  #nums @  CELLS  ALLOT

\ index into nums and rect
: nums[]        ( i -- addr )
    CELLS nums + ;
: rect[]        ( row col -- addr )
    SWAP  #cols @ *  +  CELLS  rect + ;

\ fill rect with -1
: fill_rect     ( -- )
    #rows @  0  DO
        #cols @  0  DO
            -1  J I rect[]  !
        LOOP
    LOOP ;

\ fill spiral
: spiral        ( -- )
    0  #rows @ 1-  0    { i r c }   \ start at bottom left
    BEGIN i #nums @ < WHILE         \ while numbers left
        \ go East
        BEGIN c #cols @ <  r c rect[] @ 0< AND WHILE
            i nums[] @  r c rect[] !        \ store number
            i 1+ TO i
            c 1+ TO c
        REPEAT
        c 1- TO c
        r 1- TO r
        \ go North
        BEGIN r 0>=  r c rect[] @ 0< AND WHILE
            i nums[] @  r c rect[] !        \ store number
            i 1+ TO i
            r 1- TO r
        REPEAT
        r 1+ TO r
        c 1- TO c
        \ go West
        BEGIN c 0>=  r c rect[] @ 0< AND WHILE
            i nums[] @  r c rect[] !        \ store number
            i 1+ TO i
            c 1- TO c
        REPEAT
        c 1+ TO c
        r 1+ TO r
        \ go South
        BEGIN r #rows @ <  r c rect[] @ 0< AND WHILE
            i nums[] @  r c rect[] !        \ store number
            i 1+ TO i
            r 1+ TO r
        REPEAT
        r 1- TO r
        c 1+ TO c
    REPEAT
;

\ print spiral
: .spiral       ( -- )
    #rows @  0  DO
        #cols @  0  DO
            J I rect[]  @  width @ 1+  U.R
        LOOP
        CR
    LOOP ;


fill_rect spiral .spiral
BYE
