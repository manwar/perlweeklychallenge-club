#! /usr/bin/env gforth

\ Challenge 209
\
\ Task 1: Special Bit Characters
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of binary bits that ends with 0.
\
\ Valid sequences in the bit string are:
\
\ [0] -decodes-to-> "a"
\ [1, 0] -> "b"
\ [1, 1] -> "c"
\
\ Write a script to print 1 if the last character is an “a” otherwise print 0.
\ Example 1
\
\ Input: @bits = (1, 0, 0)
\ Output: 1
\
\ The given array bits can be decoded as 2-bits character (10) followed by
\ 1-bit character (0).
\
\ Example 2
\
\ Input: @bits = (1, 1, 1, 0)
\ Output: 0
\
\ Possible decode can be 2-bits character (11) followed by 2-bits character
\ (10) i.e. the last character is not 1-bit character.

\ line of decoded text
CREATE output 0 C, 255 ALLOT
0 VALUE last_output_is_a

: append_output ( ch -- )
    DUP 'a' = IF 1 TO last_output_is_a ELSE 0 TO last_output_is_a THEN
    output COUNT + C!
    output C@ 1+ output C!
;

: append_a 'a' append_output ;
: append_b 'b' append_output ;
: append_c 'c' append_output ;

CREATE input 256 ALLOT

: set_input { addr len -- }
    1 input C!              \ next char pointer
    addr input 1+ len CMOVE
    0  input 1+ len + C!    \ end marker
;

: cur_input ( -- ch|0 )
    input C@ input + C@
;

: next_input ( -- ch|0 )
    cur_input 0<> IF
        input C@ 1+ input C!
    THEN
    cur_input
;

: skip_input ( -- )
    next_input DROP
;

: decode_str ( -- )
    0 { decode_state }
    BEGIN
        decode_state 0= IF
            cur_input 0= IF EXIT ELSE
            cur_input '0' = IF append_a skip_input ELSE
            cur_input '1' = IF 1 TO decode_state skip_input ELSE
            EXIT
            THEN THEN THEN
        ELSE
            cur_input 0= IF EXIT ELSE
            cur_input '0' = IF append_b skip_input 0 TO decode_state ELSE
            cur_input '1' = IF append_c skip_input 0 TO decode_state ELSE
            EXIT
            THEN THEN THEN
        THEN
    AGAIN
;

NEXT-ARG set_input
decode_str
last_output_is_a . CR
BYE
