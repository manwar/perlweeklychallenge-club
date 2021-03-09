#! /usr/bin/env gforth

\ Challenge 099
\
\ TASK #2 › Unique Sub-sequence
\ Submitted by : Mohammad S Anwar
\ You are given two strings $S and $T.
\
\ Write a script to find out count of different unique sub-sequences matching
\ $T without changing the position of characters.
\
\ Example 1:
\ Input : $S = "littleit', $T = 'lit'
\ Output : 5
\
\     1: [lit] tleit
\     2: [li] t[t] leit
\     3: [li] ttlei[t]
\     4: litt[l] e[it]
\     5: [l] ittle[it]
\ Example 2:
\ Input : $S = "london', $T = 'lon'
\ Output : 3
\
\     1: [lon] don
\     2: [lo] ndo[n]
\     3: [l] ond[on]

\ output number without space
: .num              ( n -- )
    0 U.R
;

: count_subsequences    { s-addr s-len t-addr t-len -- n }
    BEGIN
        t-len 0= IF 1 EXIT THEN     \ t="", matched
        s-len 0= IF 0 EXIT THEN     \ s="", did not match
        s-addr C@ t-addr C@ = IF    \ same char
            s-addr s-len 1 /STRING t-addr t-len 1 /STRING RECURSE
            s-addr s-len 1 /STRING t-addr t-len           RECURSE
            + EXIT
        ELSE
            s-addr s-len 1 /STRING TO s-len TO s-addr   \ cut first char
        THEN
    AGAIN
;

NEXT-ARG NEXT-ARG count_subsequences .num CR BYE
