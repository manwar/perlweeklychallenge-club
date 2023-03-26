#! /usr/bin/env gforth

\ Challenge 197
\
\ Task 1: Pattern 132
\ Submitted by: Mohammad S Anwar
\ You are given a list of integers, @list.
\
\ Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.
\
\
\ Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].
\
\
\ Example 1
\ Input:  @list = (3, 1, 4, 2)
\ Output: (1, 4, 2) respect the Pattern 132.
\ Example 2
\ Input: @list = (1, 2, 3, 4)
\ Output: () since no susbsequence can be found.
\ Example 3
\ Input: @list = (1, 3, 2, 4, 6, 5)
\ Output: (1, 3, 2) if more than one subsequence found then return the first.
\ Example 4
\ Input: @list = (1, 3, 4, 2)
\ Output: (1, 3, 2)

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

: print_pattern_sub ( -- )
    0 { i } BEGIN i nums_size 2 - < WHILE
        i 1+ { j } BEGIN j nums_size 1- < WHILE
            j 1+ { k } BEGIN k nums_size < WHILE
                i nums[] @ k nums[] @ <
                k nums[] @ j nums[] @ < AND IF
                    i nums[] @ . j nums[] @ . k nums[] @ .
                    EXIT
                THEN
            k 1+ TO k REPEAT
        j 1+ TO j REPEAT
    i 1+ TO i REPEAT
;

: print_pattern132 ( -- )
    '(' EMIT print_pattern_sub ')' EMIT CR
;

collect_args
print_pattern132
BYE
