#! /usr/bin/env gforth

\ Challenge 208
\
\ Task 1: Minimum Index Sum
\ Submitted by: Mohammad S Anwar
\
\ You are given two arrays of strings.
\
\ Write a script to find out all common strings in the given two arrays with
\ minimum index sum. If no common strings found returns an empty list.
\ Example 1
\
\ Input: @list1 = ("Perl", "Raku", "Love")
\        @list2 = ("Raku", "Perl", "Hate")
\
\ Output: ("Perl", "Raku")
\
\ There are two common strings "Perl" and "Raku".
\ Index sum of "Perl": 0 + 1 = 1
\ Index sum of "Raku": 1 + 0 = 1
\
\ Example 2
\
\ Input: @list1 = ("A", "B", "C")
\        @list2 = ("D", "E", "F")
\
\ Output: ()
\
\ No common string found, so no result.
\
\ Example 3
\
\ Input: @list1 = ("A", "B", "C")
\        @list2 = ("C", "A", "B")
\
\ Output: ("A")
\
\ There are three common strings "A", "B" and "C".
\ Index sum of "A": 0 + 1 = 1
\ Index sum of "B": 1 + 2 = 3
\ Index sum of "C": 2 + 0 = 2

\ string storage: addr, len; strings kept in command line storage
2 CELLS VALUE str.sizeof

\ string list storage
: list.size ( list -- list-size-addr )      0 CELLS + ;
: list.item[] ( list idx -- str-addr )      2* CELLS CELL + + ;

\ clear list
: list.clear ( list -- )
    0 SWAP !
;

\ push string to list
: list.push { addr len list -- }
    addr len  list list.size @  list SWAP list.item[]  2!
    1 list list.size +!
;

\ create list
: list.create ( size -- | name )
    CREATE 0 , ( len ) str.sizeof * ALLOT
;

\ print list
: list.print ( list -- )
    DUP @ ( len )
    DUP IF
        SWAP CELL + SWAP ( addr++ )
        0 ?DO
            DUP 2@ TYPE SPACE
            str.sizeof +
        LOOP
        DROP
    ELSE
        2DROP ." ()"
    THEN
    CR
;

\ three lists
256 list.create list1
256 list.create list2
256 list.create common

\ collect lists from command line
: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        list1 list.push
    REPEAT
    2DROP
;

\ split list1 to list2
: split_list { from to -- }
    from list.size @ 2 / { n }
    n 0 ?DO
        from n I + list.item[] 2@
        to list.push
    LOOP
    n from list.size !
;

\ common strings with lowest index
: common_strings { list1 list2 common -- }
    list1 list.size @  list2 list.size @  1+ { min_index }
    list1 list.size @ 0 ?DO
        list2 list.size @ 0 ?DO
            list1 J list.item[] 2@
            list2 I list.item[] 2@
            COMPARE 0= IF
                I J + min_index < IF
                    common list.clear
                    list1 J list.item[] 2@  common list.push
                    I J + TO min_index
                ELSE I J + min_index = IF
                    list1 J list.item[] 2@  common list.push
                    I J + TO min_index
                THEN THEN
            THEN
        LOOP
    LOOP
;

collect_args
list1 list2 split_list
list1 list2 common common_strings
common list.print
BYE
