#! /usr/bin/env gforth

\ Challenge 123
\
\ TASK #1 > Ugly Numbers
\ Submitted by: Mohammad S Anwar
\ You are given an integer $n >= 1.
\
\ Write a script to find the $nth element of Ugly Numbers.
\
\ Ugly numbers are those number whose prime factors are 2, 3 or 5. For example,
\ the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
\
\ Example
\ Input: $n = 7
\ Output: 8
\
\ Input: $n = 10
\ Output: 12

\ circular queue of integers
1024 CONSTANT Q_SIZE                \ must be power of 2

: q.pFront  ( q -- front-addr ) ;
: q.pBack   ( q -- back-addr )  1 CELLS + ;
: q.pData   ( q -- data-addr )  2 CELLS + ;
: e.empty   ( q -- f )          DUP q.pFront @ Q_SIZE MOD
                                SWAP q.pBack @ Q_SIZE MOD = ;
: q.pElem   ( q index - addr )  Q_SIZE MOD CELLS SWAP q.pData + ;

: create_q  ( -- )
    CREATE 0 , 0 , Q_SIZE ALLOT     \ front back data...data
;

: q.Front   ( q -- front-elem )
    DUP q.pFront @                  ( q index )
    q.pElem @
;

: q.Back    ( q -- back-elem )
    DUP q.pBack @ 1-                ( q index )
    q.pElem @
;

: q.PushBack    ( q elem -- )
    OVER q.pBack @                  ( q elem back )
    2 PICK SWAP                     ( q elem q back )
    q.pElem                         ( q elem elem-addr )
    !                               ( q )
    q.pBack 1 SWAP +!               \ increment
;

: q.PopBack     ( q -- )
    q.pBack -1 SWAP +!
;

: q.PushFront   ( q elem -- )
    OVER q.pFront -1 SWAP +!        \ decrement front
    SWAP dup q.pFront @ q.pElem !
;

: q.PopFront    ( q -- )
    q.pFront 1 SWAP +!
;


\ queue or powers of 2, 3 and 5
create_q q2  q2 1 q.PushBack
create_q q3  q3 1 q.PushBack
create_q q5  q5 1 q.PushBack


\ generate the next hamming number
: next_hamming  ( -- n )
    \ get the smallest of the queue heads
    q2 q.Front  q3 q.Front  MIN  q5 q.Front  MIN    ( n )

    \ shift used multiples
    q2 q.Front OVER = IF q2 q.PopFront THEN
    q3 q.Front OVER = IF q3 q.PopFront THEN
    q5 q.Front OVER = IF q5 q.PopFront THEN

    \ push next multiples
    2 OVER * q2 SWAP q.PushBack
    3 OVER * q3 SWAP q.PushBack
    5 OVER * q5 SWAP q.PushBack
;


\ generate sequence of hamming numbers
: hamming       ( n -- )
    0 ?DO
        next_hamming . CR
    LOOP
;


\ get command line argument, call hamming
NEXT-ARG S>NUMBER? 0= THROW DROP
hamming
BYE
