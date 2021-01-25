\ THE WEEKLY CHALLENGE - 091
\ TASK #1: Count Number
\
\ You are given a positive number $N. Write a script to count number and
\ display as you read it.

\ Start the script with N in the stack, e.g.
\   gforth -e 12345 ch-1.fs

\ This solution uses the data stack to hold the digit counts, while
\ computing them right-to-left, and displays them left-to-right at
\ the end. A -1 is used as a stack marker, as there cannot be a -1
\ digit count.

: count_digit   ( n -- d c n/10^c )     \ count last digit
    DUP 10 MOD 0        ( n d c )
    BEGIN
        ROT 10 /        ( d c n/10 )
        ROT ROT 1+      ( n/10 d c+1 )
        2 PICK 10 MOD   ( n/10 d c+1 new-d )
        2 PICK          ( n/10 d c+1 new-d d )
    <> UNTIL
    ROT                 ( d c new-n )
;

: out-num       ( n -- )               \ print number without space
    1 .r
;

: read_number   ( n -- )
    -1 SWAP             ( -1 n )        \ add -1 as marker
    BEGIN               ( -1 [d c]... n ) \ decompose each group
        count_digit     ( ... d c new-n )
    DUP 0 <= UNTIL      ( -1 [d c]... n )
    DROP
    BEGIN
        out-num out-num \ print count, digit
    DUP 0< UNTIL
    DROP
    CR
;

read_number BYE
