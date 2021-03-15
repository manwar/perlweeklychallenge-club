#! /usr/bin/env gforth

\ Challenge 094
\
\ TASK #2 › Binary Tree to Linked List
\ Submitted by: Mohammad S Anwar
\ You are given a binary tree.
\
\ Write a script to represent the given binary tree as an object and flatten
\ it to a linked list object. Finally print the linked list object.
\
\ Example:
\   Input:
\
\       1
\      / \
\     2   3
\    / \
\   4   5
\      / \
\     6   7
\
\   Output:
\
\       1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

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

\ -----------------------------------------------------------------------------
\ Flatten the tree
: flatten_tree          { root -- }
    root IF                     \ root not null
        root node.left @        ( left )
        DUP RECURSE             \ flatten left sub-tree

        root node.right @       ( left right )
        DUP RECURSE             \ flatten right sub-tree

        0 root node.left !      \ left = 0
        SWAP root node.right !  \ right = left; ( right )

        root                    ( right node )
        BEGIN DUP node.right @ WHILE
            node.right @
        REPEAT                  ( right rightmost-node )
        node.right !
    THEN
;

: print_tree    ( root )
    BEGIN ?DUP WHILE
        DUP node.value @ .
        DUP node.right @ IF ." -> " THEN
        node.right @
    REPEAT
    CR
;

parse_tree VALUE tree           \ parse tree, save root
tree flatten_tree               \ flatten the tree
tree print_tree
BYE
