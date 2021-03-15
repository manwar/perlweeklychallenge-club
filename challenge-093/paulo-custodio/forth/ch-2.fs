#! /usr/bin/env gforth

\ Challenge 093
\
\ TASK #2 › Sum Path
\ Submitted by: Mohammad S Anwar
\ You are given binary tree containing numbers 0-9 only.
\
\ Write a script to sum all possible paths from root to leaf.
\
\ Example 1:
\ Input:
\      1
\     /
\    2
\   / \
\  3   4
\
\ Output: 13
\ as sum two paths (1->2->3) and (1->2->4)
\ Example 2:
\ Input:
\      1
\     / \
\    2   3
\   /   / \
\  4   5   6
\
\ Output: 26
\ as sum three paths (1->2->4), (1->3->5) and (1->3->6)

80 CONSTANT MAXLINE
10 CONSTANT '\n'

\ -----------------------------------------------------------------------------
\ read lines from stdin and store them in dictionary
0 VALUE num_lines

: ,line                     { src len -- }
    HERE                    ( dest )
    len ALLOT               \ reserve space
    src SWAP len CMOVE      \ copy to space
    '\n' C,                 \ append line terminator
;

: ,lines
    BEGIN
        PAD DUP MAXLINE STDIN READ-LINE THROW
    WHILE
        ,line
        num_lines 1+ TO num_lines
    REPEAT
    2DROP
;

CREATE lines ,lines

\ get start of row
: row[]                     ( row -- row-addr )
    lines SWAP              ( lines row )
    0 ?DO                   \ loop for rows
        BEGIN DUP C@ '\n' <> WHILE  \ find end of each row
            1+
        REPEAT
        1+
    LOOP
;

\ advance from start of row to column
: col[]                     ( row-addr col -- char-addr )
    0 ?DO
        DUP C@ '\n' <> IF
            1+              \ increment unless end of line
        THEN
    LOOP
;

\ get address of character at row, col
: lines[][]                 ( row col -- addr )
    SWAP row[]
    SWAP col[]
;

\ get character at row, col
: char[][]                  ( row col -- char )
    lines[][] C@
;

: char[][]isdigit           ( row col -- f )
    char[][]
    DUP '0' >= SWAP '9' <= AND
;

: char[][]isnewline         ( row col -- f )
    char[][]
    '\n' =
;

\ -----------------------------------------------------------------------------
\ Representation of a tree
3 CELLS CONSTANT NODE_SIZE

: new_node                  ( -- node )
    HERE 0 , 0 , 0 ,
;

: node.value                ( node-addr -- value-addr )
;

: node.left                 ( node-addr -- left-addr )
    1 CELLS +
;

: node.right                ( node-addr -- right-addr )
    2 CELLS +
;

: parse_subtree             { row col -- node }
    new_node                ( node )
    row col char[][] '0' -  ( node value )
    OVER node.value !       \ store value
    row 2 + num_lines < IF  \ have children
        row 1+ col 1- char[][] '/' = IF \ have left child
            row 2 + col 2 - RECURSE     ( node child-node )
            OVER node.left !            \ store left subtree
        THEN
        row 1+ col 1+ char[][] '\' = IF \ have right child
            row 2 + col 2 + RECURSE     ( node child-node )
            OVER node.right !           \ store right subtree
        THEN
    THEN
;

: parse_tree                ( -- root )
    0                       ( col )
    BEGIN
        0 OVER              ( col row col )
        char[][]isdigit IF
            0 SWAP          ( row col )
            parse_subtree
            EXIT            ( node )
        THEN
        0 OVER
        char[][]isnewline IF
            1 THROW         \ root not found
        THEN
        1+                  ( col++ )
    AGAIN
;

\ parse tree, save root
parse_tree VALUE tree_root

\ -----------------------------------------------------------------------------
\ compute path length

0 VALUE total_length

: subtree_length                ( node length -- )
    OVER node.value @ +         ( node length+node.value )
    OVER node.left @ ?DUP IF    \ add left subtree
        OVER RECURSE
    THEN
    OVER node.right @ ?DUP IF   \ add right subtree
        OVER RECURSE
    THEN
    OVER node.left  @ 0= >R
    OVER node.right @ 0= R> AND IF  \ no children
        total_length OVER + TO total_length     \ accumulate total length
    THEN
    2DROP
;

: tree_length                   ( tree -- length )
    0 TO total_length
    0 subtree_length
    total_length
;

tree_root tree_length . CR
BYE
