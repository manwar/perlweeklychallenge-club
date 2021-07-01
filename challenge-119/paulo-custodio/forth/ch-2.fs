\ Challenge 119
\
\ TASK #2 - Sequence without 1-on-1
\ Submitted by: Cheok-Yin Fung
\ Write a script to generate sequence starting at 1. Consider the increasing
\ sequence of integers which contain only 1's, 2's and 3's, and do not have any
\ doublets of 1's like below. Please accept a positive integer $N and print the
\ $Nth term in the generated sequence.
\
\ 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
\
\ Example
\ Input: $N = 5
\ Output: 13
\
\ Input: $N = 10
\ Output: 32
\
\ Input: $N = 60
\ Output: 2223

: num_ok    { n -- f }
    0 0     { digit last_digit }
    n 0<= IF FALSE EXIT THEN
    BEGIN n 0> WHILE
        digit TO last_digit
        n 10 MOD TO digit
        n 10 / TO n

        digit 1 <
        digit 3 > OR
        digit 1 = last_digit 1 = AND OR
        IF FALSE EXIT THEN
    REPEAT
    TRUE ;

: next_seq  ( n -- n )
    BEGIN
        1+
        DUP num_ok IF EXIT THEN
    AGAIN ;

: seq       ( num - n )
    0 SWAP
    0 DO next_seq LOOP ;

NEXT-ARG S>NUMBER? 0= THROW DROP
seq . CR BYE
