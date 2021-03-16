#! /usr/bin/env gforth

\ Challenge 102
\
\ TASK #1 › Rare Numbers
\ Submitted by: Mohammad S Anwar
\
\ You are given a positive integer $N.
\
\ Write a script to generate all Rare numbers of size $N if exists. Please
\ checkout the page for more information about it.
\ Examples
\
\ (a) 2 digits: 65
\ (b) 6 digits: 621770
\ (c) 9 digits: 281089082

\ 1234 -> 4321
: invert_number     { n -- }
    0 { n1 }
    BEGIN n 0<> WHILE
        n1 10 *  n 10 MOD  +  TO n1
        n 10 /  TO n
    REPEAT
    n1 ;

\ check if number is perfect square
: is_perfect_square ( n -- f )
    S>F FSQRT
    FDUP FLOOR F= IF TRUE ELSE FALSE THEN ;

\ compute 10^n
: 10pow     ( n -- 10^n )
    1 SWAP
    0 ?DO
        10 *
    LOOP ;

: .rare { n -- }
    n 10pow  n 1- 10pow DO
        I I invert_number       { r r1 }
        r r1 + is_perfect_square IF
            r r1 >= IF
                r r1 - is_perfect_square IF
                    r . CR
        THEN THEN THEN
    LOOP ;

NEXT-ARG S>NUMBER? 0= THROW DROP
.rare
BYE
