#! /usr/bin/env gforth

\ Challenge 096
\
\ TASK #1 > Reverse Words
\ Submitted by: Mohammad S Anwar
\ You are given a string $S.
\
\ Write a script to reverse the order of words in the given string. The string
\ may contain leading/trailing spaces. The string may have more than one space
\ between words in the string. Print the result without leading/trailing spaces
\ and there should be only one space between words.
\
\ Example 1:
\ Input: $S = "The Weekly Challenge"
\ Output: "Challenge Weekly The"

\ trim spaces from start of string
: trim_start        ( addr len -- addr len )
    BEGIN
        DUP 0= IF EXIT THEN             \ exit if lenth is zero
        OVER C@ BL = IF                 \ if starts with space
            1 /STRING                   \ remove first char
        ELSE
            EXIT                        \ no more spaces
        THEN
    AGAIN ;

\ trim spaces from start and end of string
: trim              ( addr len -- addr len )
    trim_start -TRAILING ;


\ clear counted string at PAD
: clear_pad         ( -- )
    0 PAD C! ;

\ concatenate string to PAD, output as counted string
: append_pad        ( addr len -- )
    PAD COUNT +     ( src len dest )    \ get address of char after string
    2DUP + >R       ( R: end of joined string )
    SWAP CMOVE                          \ copy string
    R> PAD 1+ - PAD C! ;                \ store new length

\ concatenate args from command line to one string in PAD
: join_args         ( -- )
    clear_pad
    BEGIN NEXT-ARG DUP 0> WHILE         \ while input argument
        trim append_pad                 \ trim argument and cat
        s"  " append_pad                \ cat one space
    REPEAT 2DROP
    PAD COUNT -TRAILING SWAP 1- C! ;    \ remove ending spaces

\ split a string by blanks
\ stores result in dictionary and reclaims memory
: split             ( addr len -- tokens count )
    HERE >R                             \ save dictionary pointer
    BEGIN
        trim                            \ trim start and end spaces
        2DUP 2,                         \ save rest of string; length will be
                                        \ adjusted later
        s"  " SEARCH        ( addr-space len-rest f-found )
    WHILE                               \ while found space
        DUP NEGATE  HERE 2 CELLS - +!   \ adjust last token length
    REPEAT 2DROP                        \ drop string
    R> HERE OVER -          ( addr-tokens size-bytes )
    DUP NEGATE ALLOT                    \ reclaim dictionary
    2 CELLS / ;             ( tokens count )

\ print the reversed list of tokens
: .tokens           ( tokens count -- )
    SWAP OVER 2 CELLS * + SWAP  ( addr-end count )
    0 ?DO                               \ for each token
        2 CELLS -
        DUP 2@ TYPE SPACE
    LOOP DROP ;

join_args               \ join arguments to PAD
PAD COUNT split         \ split by spaces
.tokens CR              \ print in reverse order
BYE
