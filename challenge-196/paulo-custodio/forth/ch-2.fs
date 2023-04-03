#! /usr/bin/env gforth

\ Challenge 196
\
\ Task 2: Range List
\ Submitted by: Mohammad S Anwar
\ You are given a sorted unique integer array, @array.
\
\ Write a script to find all possible Number Range i.e [x, y] represent range
\ all integers from x and y (both inclusive).
\
\
\ Each subsequence of two or more contiguous integers
\
\
\ Example 1
\ Input: @array = (1,3,4,5,7)
\ Output: [3,5]
\ Example 2
\ Input: @array = (1,2,3,6,7,9)
\ Output: [1,3], [6,7]
\ Example 3
\ Input: @array = (0,1,2,4,5,6,8,9)
\ Output: [0,2], [4,6], [8,9]

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

: nums[] ( idx -- addr )
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

: print_ranges_sub ( -- )
    FALSE { sep }
    0 { i } BEGIN i nums_size < WHILE
        0 { j } BEGIN i j + nums_size <
                      i nums[] @ j +  i j + nums[] @ = AND WHILE
        j 1+ TO j REPEAT
        j 1 > IF
            sep IF ',' EMIT SPACE THEN TRUE TO sep
            '[' EMIT i nums[] @ . ',' EMIT i j + 1- nums[] @ . ']' EMIT
            i j + 1- TO i
        THEN
    i 1+ TO i REPEAT
;

: print_ranges ( -- )
    '(' EMIT print_ranges_sub ')' EMIT CR
;

collect_args
print_ranges
BYE
