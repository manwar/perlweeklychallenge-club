#! /usr/bin/env gforth

\ Challenge 001
\
\ Challenge #1
\ Write a script to replace the character ‘e’ with ‘E’ in the string
\ ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
\ is found in the string.

\ init PAD as empty string
: clear_pad     ( -- )
    0 PAD C!
;

\ append string to PAD
: append_PAD    ( str len -- )
    PAD COUNT +         ( src len dst )
    ROT                 ( len dst src )
    SWAP                ( len src dst )
    2 PICK CMOVE        ( len )         \ copy text
    PAD C@ + PAD C!                     \ save new length
;

\ append all input args
: append_args           ( -- )
    clear_pad
    BEGIN NEXT-ARG DUP 0> WHILE
        append_pad s"  " append_pad
    REPEAT 2DROP
    PAD C@ DUP 0> IF 1- PAD C! ELSE DROP THEN   \ cut last space
;

: replace-e             ( str len -- n )
    0 ROT ROT           ( n str len )      \ n = number of chars replaced )
    BOUNDS ?DO
        I C@ 'e' = IF   \ is an 'e'
            'E' i C!    \ replace by 'E'
            1+          \ count it
        THEN
    LOOP
;

\ main
append_args
PAD COUNT replace-e .
PAD COUNT TYPE CR
BYE
