\ THE WEEKLY CHALLENGE - 091
\ TASK #1: Count Number
\
\ You are given a positive number $N. Write a script to count number and display as you read it.
\ N is in the stack, start script with:
\   gforth -e 12345 ch-1.fth

: count_digit   ( n -- d c n/10^x )     \ count last digit
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

: read_number_  ( n -- )
    -1 SWAP             ( -1 n )        \ add -1 as marker
    BEGIN               ( -1 [d c]... n ) \ decompase each group
        count_digit     ( ... d c new-n )
    DUP 0 <= UNTIL      ( -1 [d c]... n )
    DROP
    BEGIN 
        out-num out-num \ print count, digit
    DUP 0< UNTIL
    DROP
;

: read_number   ( n -- )
    read_number_ CR
;

read_number BYE
