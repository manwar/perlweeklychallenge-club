#! /usr/bin/env gforth

\ Challenge 206
\
\ Task 2: Array Pairings
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers having even number of elements..
\
\ Write a script to find the maximum sum of the minimum of each pairs.
\ Example 1
\
\ Input: @array = (1,2,3,4)
\ Output: 4
\
\ Possible Pairings are as below:
\ a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
\ b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
\ c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
\
\ So the maxium sum is 4.
\
\ Example 2
\
\ Input: @array = (0,2,1,3)
\ Output: 2
\
\ Possible Pairings are as below:
\ a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
\ b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
\ c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
\
\ So the maximum sum is 2.


\ list of integers
: lst_alloc { num_elems -- list_addr }
    num_elems 1+ CELLS              \ one more for the size
    ALLOCATE THROW { addr }         \ addr point at start of list
    num_elems addr !                \ store size
    num_elems 0 ?DO
        0 I 1+ CELLS addr + !       \ zero data
    LOOP
    addr
;

: lst_free ( addr -- )
    FREE THROW
;

: lst_clone { src -- dst }
    src @ lst_alloc { dst }         \ allocate a new list
    src dst src @ 1+ CELLS MOVE     \ copy the list
    dst
;

: lst_size { addr -- num_elems }
    addr @
;

: lst[] { addr idx -- elem_addr }
    idx 0 < THROW
    idx addr lst_size >= THROW
    addr idx 1+ CELLS +
;

: lst_push { n addr -- addr }
    addr addr lst_size 2 + CELLS RESIZE THROW { new_addr }
    new_addr lst_size 1+ new_addr !     \ store new size
    n new_addr DUP lst_size 1- lst[] !  \ store new element
    new_addr
;

: lst_erase { addr idx -- }
    idx 1+ addr lst_size < IF
        addr idx 1+ lst[]
        addr idx lst[]
        addr lst_size idx 1+ - CELLS
        MOVE
    THEN
    addr @ 1- addr !
;


\ collect arguments from input, store in list
: collect_args ( -- list )
    0 lst_alloc { list }
    BEGIN NEXT-ARG DUP WHILE        \ while argments
        0 0 2SWAP >NUMBER 2DROP DROP
        list lst_push TO list
    REPEAT
    2DROP
    list
;


\ pairs sum
: lst_pairs_sum { addr -- sum }
    0                                   ( sum )
    addr lst_size 0 ?DO
        addr i lst[] @
        addr i 1+ lst[] @
        MIN +
    2 +LOOP
;


\ compute maximum sum of the minimum of each pair
VARIABLE max_sum

: compute_max_sum { set pending -- }
    pending lst_size 0= IF
        set lst_pairs_sum
        max_sum @  MAX  max_sum !
    ELSE                                \ recurse for each pair
        pending lst_size 1-  0  ?DO
            pending lst_size  I 1+  ?DO
                set lst_clone { new_set }
                pending lst_clone { new_pending }

                pending J lst[] @  new_set  lst_push TO new_set
                pending I lst[] @  new_set  lst_push TO new_set

                new_pending I lst_erase
                new_pending J lst_erase

                new_set new_pending RECURSE

                new_set lst_free
                new_pending lst_free
            LOOP
        LOOP
    THEN
;

: task ( -- max )
    0 max_sum !
    0 lst_alloc { set }
    collect_args { pending }
    set pending compute_max_sum
    set lst_free
    pending lst_free
    max_sum @
;


task . CR
BYE
