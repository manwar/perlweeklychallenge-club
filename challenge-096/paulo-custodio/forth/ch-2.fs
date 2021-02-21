#! /usr/bin/env gforth

\ Challenge 096
\
\ TASK #2 > Edit Distance
\ Submitted by: Mohammad S Anwar
\ You are given two strings $S1 and $S2.
\
\ Write a script to find out the minimum operations required to convert $S1
\ into $S2. The operations can be insert, remove or replace a character. Please
\ check out Wikipedia page for more information.
\
\ Example 1:
\ Input: $S1 = "kitten"; $S2 = "sitting"
\ Output: 3
\
\ Operation 1: replace 'k' with 's'
\ Operation 2: replace 'e' with 'i'
\ Operation 3: insert 'g' at the end
\ Example 2:
\ Input: $S1 = "sunday"; $S2 = "monday"
\ Output: 2
\
\ Operation 1: replace 's' with 'm'
\ Operation 2: replace 'u' with 'o'


\ collect arguments - strings a and b
NEXT-ARG CONSTANT len_a CONSTANT a
NEXT-ARG CONSTANT len_b CONSTANT b

\ get string char by index (1..N)
: a[]@      ( index -- char )
    a + 1- C@ ;

: b[]@      ( index -- char )
    b + 1- C@ ;

\ build array len_a+1 rows, len_b+1 cols
CREATE d
len_a 1+ len_b 1+ * CELLS ALLOT

\ index array
: d[]       ( i j -- addr )
    SWAP len_b 1+ * + CELLS
    d + ;

\ init array to zeros
: clear_d   ( -- )
    len_a 1+ 0 ?DO
        len_b 1+ 0 ?DO
            0 J I d[] !
        LOOP
    LOOP ;

\ init source column
: init_source   ( -- )
    len_a 1+ 1 ?DO
        i  i 0 d[]  !
    LOOP ;

\ init target row
: init_target   ( -- )
    len_b 1+ 1 ?DO
        i  0 i d[]  !
    LOOP ;

\ flood-fill table
: flood_fill    ( -- )
    len_b 1+ 1 ?DO
        len_a 1+ 1 ?DO
            i 1- j d[] @ 1+         \ deletion
            i j 1- d[] @ 1+         \ insertion
            i 1- j 1- d[] @         \ substitution
                i a[]@ j b[]@ <> IF 1+ THEN
            MIN MIN
            i j d[] !
        LOOP
    LOOP ;

\ output number without space
: .num              ( n -- )
    0 U.R ;

: wag_fis_dist  ( -- n )
    clear_d init_source init_target flood_fill
    len_a len_b d[] @ ;

wag_fis_dist .num CR
BYE
