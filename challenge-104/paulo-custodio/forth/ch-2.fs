#! /usr/bin/env gforth

\ Challenge 104
\
\ TASK #2 › NIM Game
\ Submitted by: Mohammad S Anwar
\ Write a script to simulate the NIM Game.
\
\ It is played between 2 players. For the purpose of this task, let assume you
\ play against the machine.
\
\ There are 3 simple rules to follow:
\
\ a) You have 12 tokens
\ b) Each player can pick 1, 2 or 3 tokens at a time
\ c) The player who picks the last token wins the game

require random.fs

0 CONSTANT A
1 CONSTANT B
12 CONSTANT tokens
100000 CONSTANT runs

: .num              ( n -- )
    0 U.R
;

: play-to-win   { t -- n }
    t 3 <=      IF t EXIT THEN
    t 4 MOD 0=  IF 1 EXIT THEN
    t 5 MOD 0=  IF 1 EXIT THEN
    t 6 MOD 0=  IF 2 EXIT THEN
    t 7 MOD 0=  IF 3 EXIT THEN
    t 9 MOD 0=  IF 2 EXIT THEN
    t 11 MOD 0= IF 2 EXIT THEN
    1 ;

: play-random   { t -- n }
    3 random 1+ ;

' play-to-win VALUE play-xt

CREATE wins 0 , 0 ,

: wins[]    ( i -- addr )
    CELLS wins + ;

: match     { T -- n }  \ run match, return player that won
    BEGIN
        \ player A
        T play-to-win  T SWAP - TO T        \ plays
        T 1 < IF A EXIT THEN                \ A wins

        \ player B
        T play-xt EXECUTE  T SWAP - TO T    \ plays
        T 1 < IF B EXIT THEN                \ B wins
    AGAIN ;

: matches   ( runs -- )     \ run matches, compute wins
    0. wins 2!
    0 ?DO
        tokens match
        wins[] 1 SWAP +!
    LOOP ;

: go
    NEXT-ARG DUP 0= THROW
    S" random" COMPARE 0= IF
        ['] play-random TO play-xt
    ELSE
        ['] play-to-win TO play-xt
    THEN
    runs matches

    ." A wins "
    A wins[] @ 100 *
    A wins[] @  B wins[] @  +  /  .num
    ." % of the matches." CR ;

go BYE
