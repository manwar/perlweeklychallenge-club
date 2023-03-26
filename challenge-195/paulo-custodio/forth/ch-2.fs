#! /usr/bin/env gforth

\ Challenge 195
\
\ Task 2: Most Frequent Even
\ Submitted by: Mohammad S Anwar
\ You are given a list of numbers, @list.
\
\ Write a script to find most frequent even numbers in the list. In case you
\ get more than one even numbers then return the smallest even integer. For all
\ other case, return -1.
\
\ Example 1
\ Input: @list = (1,1,2,6,2)
\ Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears
\ the most.
\ Example 2
\ Input: @list = (1,3,5,7)
\ Output: -1 since no even numbers found in the list
\ Example 3
\ Input: @list = (6,4,4,6,1)
\ Output: 4 since there are only two even numbers 4 and 6. They both appears
\ the equal number of times, so pick the smallest.

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

: max_nums ( -- n )
    0
    nums_size 0 ?DO
        I nums[] @ MAX
    LOOP
;

0 VALUE hist
0 VALUE hist_size

: hist[] ( idx -- addr )
    CELLS hist +
;

: make_hist ( -- )
    max_nums 1+ DUP TO hist_size
    CELLS ALLOCATE THROW TO hist
    hist hist_size CELLS ERASE
    nums_size 0 ?DO
        I nums[] @  hist[]  1 SWAP +!
    LOOP
;

: max_even ( -- )
    make_hist
    -1 0            ( n max )
    hist_size 0 ?DO
        I hist[] @ OVER > IF
            2DROP I I hist[] @
        THEN
    2 +LOOP
    DROP
;

collect_args
max_even . CR
BYE
