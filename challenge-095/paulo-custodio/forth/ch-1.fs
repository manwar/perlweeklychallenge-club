#! /usr/bin/env gforth

\ Challenge 095
\
\ TASK #1 › Palindrome Number
\ Submitted by: Mohammad S Anwar
\ You are given a number $N.
\
\ Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.
\
\ Example 1:
\ Input: 1221
\ Output: 1
\ Example 2:
\ Input: -101
\ Output: 0, since -101 and 101- are not the same.
\ Example 3:
\ Input: 90
\ Output: 0

: is_palindrome { n -- f }
    n 0< IF 0 EXIT THEN         \ if <0 -> return 0

    1 BEGIN n OVER 10 * > WHILE
        10 *
    REPEAT                      ( p10 ) \ highest power of 10 less than n

    BEGIN n 10 >= WHILE
        n OVER /                ( n / p10 )
        n 10 MOD                ( n % 10 )
        <> IF DROP 0 EXIT THEN  \ if different -> return 0

        n OVER MOD 10 / TO n    \ remove hight and low digits
        100 /                   \ divide p10 by 100
    REPEAT
    DROP 1                      \ less than 10 -> return 1
;

next-arg evaluate               \ convert argument to integer
is_palindrome . CR
BYE
