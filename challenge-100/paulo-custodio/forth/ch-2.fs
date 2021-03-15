#! /usr/bin/env gforth

\ Challenge 100
\ 
\ TASK #2 > Triangle Sum
\ Submitted by: Mohammad S Anwar
\ You are given triangle array.
\
\ Write a script to find the minimum path sum from top to bottom.
\
\ When you are on index i on the current row then you may move to either
\ index i or index i + 1 on the next row.
\
\ Example 1:
\ Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
\ Output: 8
\
\ Explanation: The given triangle
\
\             1
\            2 4
\           6 4 9
\          5 1 7 2
\
\ The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
\
\              [1]
\            [2]  4
\            6 [4] 9
\           5 [1] 7 2
\ Example 2:
\ Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
\ Output: 7
\
\ Explanation: The given triangle
\
\             3
\            3 1
\           5 2 3
\          4 3 1 3
\
\ The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
\
\              [3]
\             3  [1]
\            5 [2] 3
\           4 3 [1] 3

\ create a square to store the triangle
20 CONSTANT max-height          \ maximum height of triangle
CREATE triangle max-height DUP * CELLS ALLOT

\ get address of value at row,col, 0-based
: triangle[]    ( row col -- addr )
    SWAP max-height * + CELLS triangle +
;

\ skip non-digits
: skip-non-digits       ( str len -- str len )
    BEGIN
        DUP 0= IF EXIT THEN                             \ string empty
        OVER C@ DUP '0' >= SWAP '9' <= AND IF EXIT THEN \ digit
        1 /STRING
    AGAIN
;

\ store last filled row of triangle
-1 VALUE last-row

\ parse a list of values from string, store at last-row
: parse-line            ( str len -- )
    last-row 1+ TO last-row
    last-row 1+ 0 ?DO
        skip-non-digits
        0 0 2SWAP >NUMBER 2SWAP DROP        \ convert one number
        last-row I triangle[] !
    LOOP
    2DROP
;

\ parse and store triangle
: parse-triangle        ( -- )
    -1 TO last-row
    BEGIN NEXT-ARG DUP 0> WHILE
        parse-line
    REPEAT 2DROP
    last-row 0< THROW
;

\ compute the minimum sum of a sub-triangle
: min-sum-1     { sum row col -- min-sum }
    row col triangle[] @ sum + TO sum
    row last-row = IF
        sum
    ELSE
        sum row 1+ col    RECURSE       \ compute left sum
        sum row 1+ col 1+ RECURSE       \ comppute right sum
        MIN
    THEN
;

: min-sum       ( -- min-sum )
    0 0 0 min-sum-1
;

\ main
parse-triangle min-sum . CR BYE
