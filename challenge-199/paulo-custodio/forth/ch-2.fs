#! /usr/bin/env gforth

\ Challenge 199
\
\ Task 2: Good Triplets
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers, @array and three integers $x,$y,$z.
\
\ Write a script to find out total Good Triplets in the given array.
\
\ A triplet array[i], array[j], array[k] is good if it satisfies the following
\ conditions:
\
\ a) 0 <= i < j < k <= n (size of given array)
\ b) abs(array[i] - array[j]) <= x
\ c) abs(array[j] - array[k]) <= y
\ d) abs(array[i] - array[k]) <= z
\
\ Example 1
\
\ Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
\ Output: 4
\
\ Good Triplets are as below:
\ (3,0,1) where (i=0, j=1, k=2)
\ (3,0,1) where (i=0, j=1, k=3)
\ (3,1,1) where (i=0, j=2, k=3)
\ (0,1,1) where (i=1, j=2, k=3)
\
\ Example 2
\
\ Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
\ Output: 0

CREATE nums 256 CELLS ALLOT
0 VALUE nums_size

0 VALUE x  0 VALUE y  0 VALUE z

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

: pop_nums ( -- n )
    nums_size 1 < THROW
    nums_size 1- DUP nums[] @       ( size-1 n )
    SWAP TO nums_size
;

: count_good_triplets ( -- )
    0 0 0 { i j k }
    0                           ( count )
    0 TO i
    BEGIN i nums_size 2 - < WHILE
        i 1+ TO j
        BEGIN j nums_size 1- < WHILE
            j 1+ TO k
            BEGIN k nums_size < WHILE
                i nums[] @  j nums[] @  - ABS  x <=
                j nums[] @  k nums[] @  - ABS  y <=  AND
                i nums[] @  k nums[] @  - ABS  z <=  AND
                IF 1+ THEN
                k 1+ TO k
            REPEAT
            j 1+ TO j
        REPEAT
        i 1+ TO i
    REPEAT
;

collect_args nums_size 6 < THROW
pop_nums TO z
pop_nums TO y
pop_nums TO x
count_good_triplets . CR
BYE
