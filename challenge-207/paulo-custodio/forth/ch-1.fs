#! /usr/bin/env gforth

\ Challenge 207
\
\ Task 1: Keyboard Word
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of words.
\
\ Write a script to print all the words in the given array that can be types
\ using alphabet on only one row of the keyboard.
\
\ Let us assume the keys are arranged as below:
\
\ Row 1: qwertyuiop
\ Row 2: asdfghjkl
\ Row 3: zxcvbnm
\
\ Example 1
\
\ Input: @words = ("Hello","Alaska","Dad","Peace")
\ Output: ("Alaska","Dad")
\
\ Example 2
\
\ Input: @array = ("OMG","Bye")
\ Output: ()


\ copy text to counted string, convert to upper case
: copy_text { addr-from len addr-to -- }
    len 0 ?DO
        addr-from I + C@ TOUPPER
        addr-to 1+ I + C!
    LOOP
    len addr-to C!
;

\ remove char from text
CREATE remove_char_ch 1 ALLOT
: remove_char { addr-cstr ch -- }
    ch TOUPPER remove_char_ch C!
    BEGIN
        addr-cstr COUNT  remove_char_ch 1  SEARCH       \ while char is found
    WHILE
        { rest-addr rest-len }
        rest-addr 1+  rest-addr  rest-len  CMOVE
        addr-cstr C@ 1- addr-cstr C!
    REPEAT
    2DROP
;

\ check if word can be typed with chars
CREATE check_text 256 ALLOT
: can_type_word { addr-keys len-keys addr-text len-text -- }
    addr-text len-text check_text copy_text     \ make a copy
    len-keys 0 ?DO
        addr-keys I + C@            ( key )
        check_text SWAP remove_char
    LOOP
    check_text C@ 0=                \ true if empty
;

\ check if word can by typed with one row of the keyboard
: can_type { addr-text len-text -- }
    S" qwertyuiop"  addr-text len-text can_type_word
    S" asdfghjkl"   addr-text len-text can_type_word  OR
    S" zxcvbnm"     addr-text len-text can_type_word  OR
;

\ check all command line words
: task ( -- )
    BEGIN NEXT-ARG DUP WHILE
        2DUP can_type IF
            TYPE SPACE
        ELSE
            2DROP
        ENDIF
    REPEAT
    2DROP
    CR
;

task
BYE
