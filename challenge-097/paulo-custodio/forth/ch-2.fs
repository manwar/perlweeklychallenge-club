#! /usr/bin/env gforth

\ Challenge 097
\
\ TASK #2 › Binary Substings
\ Submitted by: Mohammad S Anwar
\ You are given a binary string $B and an integer $S.
\
\ Write a script to split the binary string $B of size $S and then find the
\ minimum number of flips required to make it all the same.
\
\ Example 1:
\ Input: $B = “101100101”, $S = 3
\ Output: 1
\
\ Binary Substrings:
\     "101": 0 flip
\     "100": 1 flip to make it "101"
\     "101": 0 flip
\ Example 2:
\ Input $B = “10110111”, $S = 4
\ Output: 2
\
\ Binary Substrings:
\     "1011": 0 flip
\     "0111": 2 flips to make it "1011"


\ count number of flipped chars
: flipped-chars     { str1 str2 len -- count }
    0               ( count )
    len 0 ?DO
        str1 I + C@
        str2 I + C@
        <> IF 1+ THEN
    LOOP
;

\ count number of flips in sequence
: flipped-sequence  { str len n -- count }
    0 str                   ( count cur-str )
    BEGIN
        n +                 \ advance to next subtring
        DUP str len + <
    WHILE                   \ for each substring
        str OVER n flipped-chars    ( count str delta )
        ROT + SWAP                  ( count str )
    REPEAT DROP
;

\ main
NEXT-ARG                            ( str len )
NEXT-ARG S>NUMBER? 0= THROW DROP    ( str len n )
flipped-sequence . CR
BYE
