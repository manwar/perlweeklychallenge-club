#! /usr/bin/env gforth

\ Challenge 098
\
\ TASK #1 › Read N-characters
\ Submitted by: Mohammad S Anwar
\ You are given file $FILE.
\
\ Create subroutine readN($FILE, $number) returns the first n-characters and
\ moves the pointer to the (n+1)th character.
\
\ Example:
\ Input: Suppose the file (input.txt) contains "1234567890"
\ Output:
\     print readN("input.txt", 4); # returns "1234"
\     print readN("input.txt", 4); # returns "5678"
\     print readN("input.txt", 4); # returns "90"


\ counted strings library
: str.new           ( size -- ) \ creates a word with size bytes to hold string
    CREATE 0 C, ALLOT ALIGN
;

: str.new_init      { src-addr size -- } \ creates a word with a copy of the string
    CREATE                          \ create word
    HERE                            ( dst )
    size 1+ ALLOT ALIGN             \ allocate memory
    src-addr OVER 1+ size CMOVE     \ copy string
    size SWAP C!                    \ set length
;

: str.clear         ( caddr -- )
    0 SWAP C!
;

: str.append        { str-addr new-addr size -- }   \ append to a string
    new-addr str-addr COUNT + size CMOVE    \ append
    str-addr C@ size + str-addr C!          \ set length
;

: str.set           { str-addr new-addr size -- }   \ set a string
    str-addr str.clear
    str-addr new-addr size str.append
;

\ buffer for input file name
255 str.new filename

\ buffer for create command
255 str.new command

\ get_file - if file is new, open it for reading and return id
\ if file exists return it's id
\ files are stored in the dictionary as constants
: get_file          { filename -- fileid }
    filename FIND               ( xt +-1 | addr 0 )
    IF                          \ word already exists and returns the fileid
        EXECUTE                 ( fileid ) \ execute constant
    ELSE
        DROP
        filename COUNT R/O OPEN-FILE THROW  ( fileid )  \ open file
        DUP                         \ copy fileid to return at the end
        command str.clear           \ create a CONSTANT command
        command S" CONSTANT " str.append
        command filename COUNT str.append
        command COUNT EVALUATE      \ create contant with fileid
    THEN
;

\ readN chars from fileid to read-buffer
255 str.new read-buffer
: readN             { fileid len -- addr len }
    read-buffer 1+ len fileid READ-FILE THROW   \ read N chars
    read-buffer C!                              \ save length
;

\ main
: main          ( -- )
    BEGIN
        filename
        NEXT-ARG DUP 0= IF DROP EXIT THEN   \ get file name, throw on error
        str.set                     \ save file name

        NEXT-ARG DUP                \ get number
    WHILE
        S>NUMBER? 0= THROW DROP     ( n )   \ convert N, drop high word
        filename get_file           ( n fileid )
        SWAP readN                  \ read string
        read-buffer COUNT TYPE CR   \ print it
    REPEAT 2DROP
;

main
BYE
