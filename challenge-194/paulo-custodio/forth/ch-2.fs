#! /usr/bin/env gforth

\ Challenge 194
\
\ Task 2: Frequency Equalizer
\ Submitted by: Mohammad S Anwar
\ You are given a string made of alphabetic characters only, a-z.
\
\ Write a script to determine whether removing only one character can make the
\ frequency of the remaining characters the same.
\
\ Example 1:
\ Input: $s = 'abbc'
\ Output: 1 since removing one alphabet 'b' will give us 'abc' where each
\ alphabet frequency is the same.
\ Example 2:
\ Input: $s = 'xyzyyxz'
\ Output: 1 since removing 'y' will give us 'xzyyxz'.
\ Example 3:
\ Input: $s = 'xzxz'
\ Output: 0 since removing any one alphabet would not give us string with same
\ frequency alphabet.

'z' 'a' - 1+ CONSTANT letters
CREATE freq letters CELLS ALLOT

: freq[] ( idx -- addr ) CELLS freq + ;

: clear_freq ( -- ) freq letters CELLS ERASE ;

: is_letter ( c -- f ) DUP 'a' >= SWAP 'z' <= AND ;

: calc_freq ( addr len -- )
    clear_freq
    BOUNDS ?DO
        I C@ DUP is_letter IF
            'a' - freq[] 1 SWAP +!
        ELSE
            DROP
        THEN
    LOOP
;

: min_freq ( -- n )
    100000
    letters 0 DO
        i freq[] @ ?DUP IF MIN THEN
    LOOP
;

: max_freq ( -- n )
    0
    letters 0 DO
        i freq[] @ ?DUP IF MAX THEN
    LOOP
;

: count_freq { n -- n }
    0
    letters 0 DO
        i freq[] @ n = IF 1+ THEN
    LOOP
;

: freq_equalizer ( addr len -- n )
    calc_freq
    min_freq max_freq 2DUP 1- <> IF 2DROP 0 ELSE
    NIP count_freq 1 <> IF 0 ELSE 1 THEN THEN
;

NEXT-ARG freq_equalizer . CR
BYE
