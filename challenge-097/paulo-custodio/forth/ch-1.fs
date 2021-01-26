#! /usr/bin/env gforth

\ Challenge 097
\
\ TASK #1 › Caesar Cipher
\ Submitted by: Mohammad S Anwar
\ You are given string $S containing alphabets A..Z only and a number $N.
\
\ Write a script to encrypt the given string $S using Caesar Cipher with left
\ shift of size $N.
\
\ Example
\ Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
\ Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
\
\ Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
\ Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
\
\ Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
\ Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

\ cipher one word
: caeser    ( n str-addr str-len -- )   \ outputs coded string
    BOUNDS ?DO
        I C@ 'A' -                      \ convert to 0..25
        OVER - 26 + 26 MOD              \ cipher
        'A' + EMIT                      \ convert back to letter
    LOOP
    DROP
    SPACE
;

\ get shift value and words from args, cipher each word
: caeser-args   ( -- )
    NEXT-ARG DUP 0= IF 1 THROW THEN     \ get first argument
    S>NUMBER? 0= THROW                  \ convert to number, thow on error
    DROP                                \ drop high part

    BEGIN NEXT-ARG DUP 0> WHILE         \ for each argument
        >R >R DUP R> R>                 ( n n addr len )
        caeser                          \ convert word
    REPEAT 2DROP
    DROP
    CR
;

caeser-args
BYE
