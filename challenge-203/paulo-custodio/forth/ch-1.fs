\ Challenge 203
\
\ Task 1: Special Quadruplets
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers.
\
\ Write a script to find out the total special quadruplets for the given array.
\
\ Special Quadruplets are such that satisfies the following 2 rules.
\ 1) nums[a] + nums[b] + nums[c] == nums[d]
\ 2) a < b < c < d
\
\
\ Example 1
\
\ Input: @nums = (1,2,3,6)
\ Output: 1
\
\ Since the only special quadruplets found is
\ $nums[0] + $nums[1] + $nums[2] == $nums[3].
\
\ Example 2
\
\ Input: @nums = (1,1,1,3,5)
\ Output: 4
\
\ $nums[0] + $nums[1] + $nums[2] == $nums[3]
\ $nums[0] + $nums[1] + $nums[3] == $nums[4]
\ $nums[0] + $nums[2] + $nums[3] == $nums[4]
\ $nums[1] + $nums[2] + $nums[3] == $nums[4]
\
\ Example 3
\
\ Input: @nums = (3,3,6,4,5)
\ Output: 0

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

: num_quadruplets ( -- n )
    0 0 0 0 { a b c d }
    0                       ( count )
    0 TO a
    BEGIN a nums_size 3 - < WHILE
        a 1+ TO b
        BEGIN b nums_size 2 - < WHILE
            b 1+ TO c
            BEGIN c nums_size 1- < WHILE
                c 1+ TO d
                BEGIN d nums_size < WHILE
                    a nums[] @ b nums[] @ + c nums[] @ + d nums[] @ = IF
                        1+
                    THEN
                    d 1+ to d
                REPEAT
                c 1+ TO c
            REPEAT
            b 1+ TO b
        REPEAT
        a 1+ TO a
    REPEAT
;

collect_args num_quadruplets . CR
BYE
