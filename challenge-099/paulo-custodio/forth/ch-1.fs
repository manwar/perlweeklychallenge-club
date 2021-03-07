#! /usr/bin/env gforth

\ Challenge 099
\ 
\ TASK #1 › Pattern Match
\ Submitted by: Mohammad S Anwar
\ You are given a string $S and a pattern $P.
\
\ Write a script to check if given pattern validate the entire string.
\ Print 1 if pass otherwise 0.
\
\ The patterns can also have the following characters:
\
\ ? - Match any single character.
\ * - Match any sequence of characters.
\ Example 1:
\ Input: $S = "abcde" $P = "a*e"
\ Output: 1
\ Example 2:
\ Input: $S = "abcde" $P = "a*d"
\ Output: 0
\ Example 3:
\ Input: $S = "abcde" $P = "?b*d"
\ Output: 0
\ Example 4:
\ Input: $S = "abcde" $P = "a*c?e"
\ Output: 1

\ output number without space
: .num              ( n -- )
    0 U.R
;

\ match string and pattern
: match         { s-addr s-len p-addr p-len -- f }
    BEGIN
        s-len 0= p-len 0= AND IF TRUE  EXIT THEN        \ string and pattern finished
        s-len 0= p-len 0= OR  IF FALSE EXIT THEN        \ string or  pattern finished
        p-addr C@ '?' = IF                              \ match any character
            s-addr s-len 1 /STRING TO s-len TO s-addr   \ cut first char
            p-addr p-len 1 /STRING TO p-len TO p-addr   \ cut first char
        ELSE p-addr C@ '*' = IF                         \ match any subtring
            p-addr p-len 1 /STRING TO p-len TO p-addr   \ cut first char
            s-len 0 ?DO
                s-addr s-len I /STRING p-addr p-len RECURSE IF
                    UNLOOP TRUE EXIT
                THEN
            LOOP
            FALSE EXIT
        ELSE s-addr C@ p-addr C@ <> IF                  \ different
            FALSE EXIT
        ELSE
            s-addr s-len 1 /STRING TO s-len TO s-addr   \ cut first char
            p-addr p-len 1 /STRING TO p-len TO p-addr   \ cut first char
        THEN THEN THEN
    AGAIN
;

NEXT-ARG NEXT-ARG match 1 AND .num CR BYE
