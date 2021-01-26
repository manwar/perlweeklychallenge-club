#! /usr/bin/env gforth

\ Challenge 094
\
\ TASK #1 › Group Anagrams
\ Submitted by: Mohammad S Anwar
\ You are given an array of strings @S.
\
\ Write a script to group Anagrams together in any random order.
\
\ An Anagram is a word or phrase formed by rearranging the letters of a
\ different word or phrase, typically using all the original letters exactly
\ once.
\
\ Example 1:
\     Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
\     Output: [ ("bat", "tab"),
\               ("saw", "was"),
\               ("top", "pot", "opt") ]
\ Example 2:
\     Input: ("x")
\     Output: [ ("x") ]

\ -----------------------------------------------------------------------------
\ counted strings

\ compare two counted strings
: cstr=         ( c-addr1 c-addr2 -- f )
    >R COUNT R> COUNT STR=
;

\ copy string as counted string to pad
: str>pad       ( addr len -- )
    DUP PAD C!
    PAD 1+ SWAP CMOVE
;

\ allot string as counted string
: cstr,         ( addr len -- )
    DUP C, >R                   \ store length
    HERE R@ CMOVE               \ copy string
    R> ALLOT                    \ advance HERE
    ALIGN
;

\ -----------------------------------------------------------------------------
\ Linked list of strings

\ create a new string list
: new_strlist           ( -- list-addr )
    HERE  0 , 0 ,
;

: strlist.head          ( list-addr -- head-addr )
;

: strlist.tail          ( list-addr -- tail-addr )
    1 CELLS +
;

\ create a new node for a string list
: new_strnode           ( addr len -- node-addr )
    HERE >R             ( R:node-addr )
    0 ,                 \ store next pointer
    cstr,               \ store string
    R>                  ( node-addr )
;

: strnode.next          ( node-addr -- next-addr )
;

: strnode.cstring       ( node-addr -- cstring-addr )
    1 CELLS +
;

\ push a string to the end of the list
: strlist.push          { addr len list-addr -- }
    addr len new_strnode    ( node-addr )
    list-addr strlist.head @ 0= IF  \ list is empty
        DUP list-addr strlist.head !
        list-addr strlist.tail !
    ELSE
        DUP
        list-addr strlist.tail @        ( new-node last-node )
        strnode.next !                  \ store node in next of last node
        list-addr strlist.tail !        \ point tail to node
    THEN
;

: strlist.print-sep         ( first -- first )
    DUP IF
        DROP 0
    ELSE
        ." , "
    THEN
;


: strlist.print         ( list-addr -- )
    1 SWAP              ( first list-addr )
    '(' EMIT
    strlist.head @      ( first node-addr )
    BEGIN DUP 0<> WHILE \ while pointer not null
        SWAP strlist.print-sep SWAP
        '"' EMIT
        DUP strnode.cstring COUNT TYPE
        '"' EMIT
        strnode.next @
    REPEAT
    ')' EMIT
    2DROP
;

\ -----------------------------------------------------------------------------
\ map of string to linked list of strings

\ create new map
: new_map               ( -- map-addr )
    HERE  0 , 0 ,
;

: map.head              ( map-addr -- head-addr )
;

: map.tail              ( map-addr -- tail-addr )
    1 CELLS +
;

\ create a new node for a map
: new_mapnode           ( addr len -- node-addr )
    HERE >R             ( R:node-addr )
    0 ,                 \ store next pointer
    new_strlist DROP    \ store list of string values
    cstr,               \ store key string
    R>                  ( node-addr )
;

: mapnode.next          ( node-addr -- next-addr )
;

: mapnode.strlist       ( node-addr -- strlist-addr )
    1 CELLS +
;

: mapnode.key           ( node-addr -- cstring-addr )
    3 CELLS +
;

: map.add_first         ( node-addr map-addr -- )
    2DUP
    map.head !
    map.tail !
;

: map.append            { node-addr map-addr -- }
    node-addr map-addr map.tail @ mapnode.next !    \ point next of last to node
    node-addr map-addr map.tail !                   \ point tail to node
;

: map.find_node         ( map-addr -- node-addr|0 ) \ find node with key in PAD
    map.head @                      ( nope-addr )
    BEGIN DUP 0<> WHILE
        DUP mapnode.key PAD cstr= IF \ same key?
            EXIT                    ( node-addr ) \ of found key
        THEN
        mapnode.next @              \ point to next
    REPEAT
                                    ( 0 ) \ entry not found
;

\ add/search a key to a map, return strlist
: map.add_key           { addr len map-addr -- node-strlist }
    addr len str>pad                    \ save key in PAD
    map-addr map.head @ 0= IF           \ map is empty
        PAD COUNT new_mapnode           ( node-addr )
        DUP map-addr map.add_first      \ add first entry
        mapnode.strlist                 ( node-strlist )
    ELSE
        map-addr map.find_node          ( node-addr|0 )
        ?DUP IF
            mapnode.strlist             ( node-strlist )
        ELSE
            PAD COUNT new_mapnode       ( node-addr )
            DUP map-addr map.append     \ append node
            mapnode.strlist             ( node-strlist )
        THEN
    THEN
;

: map.print-sep         ( first -- first )
    DUP IF
        DROP 0
    ELSE
        ',' EMIT CR 2 SPACES
    THEN
;

: map.print         ( map-addr -- )
    1 SWAP                      ( first map-addr )
    ." [ "
    map.head @                  ( first node-addr )
    BEGIN DUP 0<> WHILE
        SWAP map.print-sep SWAP ( node-addr )
        DUP mapnode.strlist strlist.print   \ print values
        mapnode.next @          \ move to next
    REPEAT
    2DROP
    ."  ]" CR
;

\ -----------------------------------------------------------------------------
\ sort a string

\ selection sort
: str-sort          { addr len }
                            \ outer loop
    len 1- 0 ?DO            \ i1: 0..len-1
        I                   ( min-idx=i1 )

                            \ inner loop: search minimum value
        len I 1+ ?DO        \ i2: i1+1..len

            I addr + C@     ( min-idx c[i2] )
            OVER addr + C@  ( min-idx c[i2] c[min-idx])
            < IF
                DROP I      ( min-idx=i2 )
            THEN
        LOOP

                            \ swap values
        I addr + C@         ( min-idx c[i1] )
        OVER addr + C@      ( min-idx c[i1] c[min-idx] )
        I addr + C!         ( min-idx c[i] )
        SWAP addr + C!      ( )
    LOOP
;

\ -----------------------------------------------------------------------------
\ main program
\ read strings from args, built map
\ print map

: build-map         { map -- }
    BEGIN NEXT-ARG ?DUP WHILE   \ read each argument
        2DUP str>pad            \ copy string to PAD
        PAD COUNT str-sort      \ build key (sorted chars of string) in PAD
                                ( arg-addr arg-size )
        PAD COUNT map map.add_key   ( arg-addr arg-size node-strlist )
        strlist.push            \ add string to values list
    REPEAT DROP
;

new_map value map
map build-map
map map.print
bye
