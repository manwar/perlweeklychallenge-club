#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Input is a single string representing the contents of a binary tree in level-
order (i.e., with nodes specified as per a breadth-first traversal). Nodes are
separated by the pipe character ("|"); empty nodes are indicated by adjacent
separators.

If no command-line arguments are given, the script runs pre-set tests to verify
correct operation.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use lib qw( . );
use BinaryTree;
use SinglyLinkedList;

const my $USAGE =>
"Usage:
  perl $0 [<tree>]

    [<tree>]    Level-order tree representation, e.g. \"a|b|c|d||e\"\n";

const my @TESTS =>
         (
             {
                 input       => '1|2|3|4|5|||||6|7',
                 expected    => '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3',
                 description => 'Example'
             },
             {
                 input       => 'a|b|c|d|e|f|g|h|i|j|k|l|m|n|o',
                 expected    => 'a -> b -> d -> h -> i -> e -> j -> k -> ' .
                                'c -> f -> l -> m -> g -> n -> o',
                 description => 'Perfect tree of depth 3'
             },
             {
                 input       => '',
                 expected    => '(empty)',
                 description => 'Empty tree'
             }
         );

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 094, Task #2: Binary Tree to Linked List (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        test();
    }
    elsif ($args == 1)
    {
        my $btree = build_tree( $ARGV[0] );
        my $sll   = SinglyLinkedList->new;

        $btree->traverse_preorder( sub { $sll->append( $_[0] ) } );
        print $sll->display, "\n";
    }
    else
    {
        print $USAGE;
    }
}

#------------------------------------------------------------------------------
sub build_tree
#------------------------------------------------------------------------------
{
    my ($tree_rep) = @_;

    # The pipe character "|" is used as the node separator; if a pipe character
    # is followed immediately by another pipe character, the node is empty:
    # i.e., there is no node in this position within the tree. Trailing empty
    # nodes may be omitted, so "a|b|c" is equivalent to "a|b|c|||||".

    my   @nodes = split / \| /x, $tree_rep;

    push @nodes, '' if scalar @nodes == 0;

    my $btree = BinaryTree->new( shift @nodes );
    my $depth =  1;
    my $count =  1;
    my $seq   = -1;

    for my $node (@nodes)
    {
        if (++$count == 2 ** ($depth + 1))
        {
            ++$depth;
            $seq = 0;
        }
        else
        {
            ++$seq;
        }

        if ($node ne '')
        {
            $btree->append_node( $depth, $seq, $node )
                or die qq[ERROR: Node "$node" has no parent\n];
        }
    }

    return $btree;
}

#------------------------------------------------------------------------------
sub test
#------------------------------------------------------------------------------
{
    use Test::More;
    plan tests => scalar @TESTS;

    for my $test (@TESTS)
    {
        my $btree = build_tree( $test->{input} );
        my $sll   = SinglyLinkedList->new;

        $btree->traverse_preorder( sub { $sll->append( $_[0] ) } );

        my $got   = $sll->display;

        is( $got, $test->{expected}, $test->{description} );
    }
}

###############################################################################
