use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 094
=========================

Task #2
-------
*Binary Tree to Linked List*

Submitted by: Mohammad S Anwar

You are given a binary tree.

Write a script to represent the given binary tree as an object and flatten it
to a linked list object. Finally print the linked list object.

Example:

    Input:

        1
       / \
      2   3
     / \
    4   5
       / \
      6   7

    Output:

        1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Input is a single string representing the contents of a binary tree in level-
order (i.e., with nodes specified as per a breadth-first traversal). Nodes are
separated by the pipe character ("|"); empty nodes are indicated by adjacent
separators.

If no command-line arguments are given, the script runs pre-set tests to verify
correct operation.

=end comment
#==============================================================================

use lib < . >;
use BinaryTree;
use SinglyLinkedList;

my constant @TESTS =
            {
                input       => '1|2|3|4|5|||||6|7',
                expected    => '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3',
                description => 'Example'
            },
            {
                input       => 'a|b|c|d|e|f|g|h|i|j|k|l|m|n|o',
                expected    => 'a -> b -> d -> h -> i -> e -> j -> k -> ' ~
                               'c -> f -> l -> m -> g -> n -> o',
                description => 'Perfect tree of depth 3'
            },
            {
                input       => '',
                expected    => '(empty)',
                description => 'Empty tree'
            };

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 094, Task #2: Binary Tree to Linked List (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str $tree?            #= Level-order tree representation, e.g. "a|b|c|d||e"
)
#==============================================================================
{
    if $tree.defined
    {
        my BinaryTree       $btree = build-tree( $tree );
        my SinglyLinkedList $sll   = SinglyLinkedList.new;

        $btree.traverse-preorder( sub ( Any:D $val ) { $sll.append( $val ) } );
        $sll.display.put;
    }
    else
    {
        test;
    }
}

#------------------------------------------------------------------------------
sub build-tree( Str:D $tree-rep --> BinaryTree:D )
#------------------------------------------------------------------------------
{
    # The pipe character "|" is used as the node separator; if a pipe character
    # is followed immediately by another pipe character, the node is empty:
    # i.e., there is no node in this position within the tree. Trailing empty
    # nodes may be omitted, so "a|b|c" is equivalent to "a|b|c|||||".

    my Str        @nodes = $tree-rep.split: '|';
    my BinaryTree $btree = BinaryTree.new( value => @nodes.shift );
    my UInt       $depth =  1;
    my UInt       $count =  1;
    my Int        $seq   = -1;

    for @nodes -> Str $node
    {
        if ++$count == 2 ** ($depth + 1)
        {
            ++$depth;
            $seq = 0;
        }
        else
        {
            ++$seq;
        }

        if $node ne ''
        {
            $btree.append-node( $depth, $seq, $node )
                or do
                   {
                       qq[ERROR: Node "$node" has no parent].put;
                       exit;
                   };
        }
    }

    return $btree;
}

#------------------------------------------------------------------------------
sub test()
#------------------------------------------------------------------------------
{
    use Test;
    plan @TESTS.elems;

    for @TESTS -> %test
    {
        my BinaryTree       $btree = build-tree( %test<input> );
        my SinglyLinkedList $sll   = SinglyLinkedList.new;

        $btree.traverse-preorder( sub ( Any:D $val ) { $sll.append( $val ) } );

        my Str              $got   = $sll.display;

        is( $got, %test<expected>, %test<description> );
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
