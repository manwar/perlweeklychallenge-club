#! /usr/bin/env gforth

\ Challenge 198
\
\ Task 2: Prime Count
\ Submitted by: Mohammad S Anwar
\ You are given an integer $n > 0.
\
\ Write a script to print the count of primes less than $n.
\
\ Example 1
\ Input: $n = 10
\ Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
\ Example 2
\ Input: $n = 15
\ Output: 6
\ Example 3
\ Input: $n = 1
\ Output: 0
\ Example 4
\ Input: $n = 25
\ Output: 9

\ https://en.wikipedia.org/wiki/Primality_test
: is_prime { n -- f }
    n 2 =  n 3 =  OR  IF TRUE ELSE
    n 1 <=  n 2 MOD 0=  n 3 MOD 0=  OR OR IF FALSE ELSE
    5 { i }
    BEGIN i i * n <= WHILE
        n i MOD 0=  n  i 2 +  MOD 0= OR IF FALSE EXIT THEN
        i 6 + TO i
    REPEAT
    TRUE
    THEN THEN
;

: next_prime ( p -- p )
    1+
    BEGIN DUP is_prime 0= WHILE
        1+
    REPEAT
;

: count_primes_below_n { n -- count }
    0 2                 ( count prime )
    BEGIN DUP n < WHILE
        SWAP 1+ SWAP
        next_prime
    REPEAT
    DROP
;

NEXT-ARG S>NUMBER? 0= THROW DROP
count_primes_below_n . CR
BYE
