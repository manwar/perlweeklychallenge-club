#!perl

###############################################################################
=comment

Perl Weekly Challenge 151
=========================

TASK #1
-------
*Binary Tree Depth*

Submitted by: Mohammad S Anwar

You are given binary tree.

Write a script to find the minimum depth.

    The minimum depth is the number of nodes from the root to the nearest leaf
    node (node without any children).

Example 1:

 Input: '1 | 2 3 | 4 5'

                 1
                / \
               2   3
              / \
             4   5

 Output: 2

Example 2:

 Input: '1 | 2 3 | 4 *  * 5 | * 6'

                 1
                / \
               2   3
              /     \
             4       5
              \
               6

 Output: 3

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Output
------
The output is the minimum depth of any leaf node (see "Note on Tree Depth"
below). In addition, if $VERBOSE is set to a true value (the default), the
value/name of that leaf node is also shown.

Note on Tree Depth
------------------
According to Wikipedia [1]:

    The root node has depth zero, ... and a tree with only a single node (hence
    both a root and leaf) has depth and height zero.

However, from the Examples above it appears that the depth of node N is here
defined as the total number of nodes (including the root) in the path from root
to N. By this definition, the root node has depth 1. This is the definition
adopted in the solution below.

Tree Representation
-------------------
A binary tree is here represented by an array of arrays, with indices as fol-
lows:
            level   width -->
              | 0   0 (root)
              V 1   0 1
                2   0 1 2 3
                3   0 1 2 3 4 5 6 7

Note that level l has width 2^l. For any arbitrary node N = (l, w):

  - N has left  child (if any) L = (l + 1, 2w    )
  - N has right child (if any) R = (l + 1, 2w + 1)

and if l > 0:

  - N has parent P = (l - 1, ⌊w / 2⌋)
  - N is a left  child if w is even
  - N is a right child if w is odd.

Algorithm
---------
Tree traversal is performed via a level-order walk (breadth-first search) which
proceeds until the first leaf node is found. The depth of this leaf node is the
required solution.

Reference
---------
[1] Wikipedia, "Tree (data structore)", Section 2: "Terminology"
    https://en.wikipedia.org/wiki/Tree_(data_structure)#Terminology

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $VERBOSE => 1;
const my $EMPTY   => '*';
const my $USAGE   =>
qq[Usage:
  perl $0 <binary_tree>

    <binary_tree>    String: "|" separates levels, "*" = an empty node\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 151, Task #1: Binary Tree Depth (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $str_rep = parse_command_line();

    printf qq[Input: "%s"\n], $str_rep;

    my $tree = build_tree( $str_rep );

    # Perform a level-order walk (breadth-first search) of the tree until the
    # first leaf node is found

    L_OUTER:
    for my $level (0 .. $#$tree)
    {
        for my $index (0 .. $#{ $tree->[ $level ] })
        {
            my $node = $tree->[ $level ][ $index ];

            if (defined $node)
            {
                if ($level == $#$tree ||
                   (!defined $tree->[ $level + 1 ][ 2 * $index     ] &&
                    !defined $tree->[ $level + 1 ][ 2 * $index + 1 ]))
                {
                    printf qq[Output: %d\n], $level + 1;
                    print  qq[\nThe first leaf node is "$node"\n] if $VERBOSE;

                    last L_OUTER;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub build_tree
#------------------------------------------------------------------------------
{
    my  ($str_rep)  = @_;
    my   @rows      = split m{ \| }x, $str_rep;
    my   $first_row = shift @rows;
    my   @tree;
    push @tree, [ undef ];

    add_root( $first_row, \@tree );

    my $level = 1;

    for my $row (@rows)
    {
        add_children( $row, $level, \@tree );

        ++$level;
    }

    return \@tree;
}

#------------------------------------------------------------------------------
sub add_root
#------------------------------------------------------------------------------
{
    my ($row, $tree) = @_;

    !defined $row || $row eq ''
        and die "ERROR: Empty tree\n";

    my @nodes = split ' ', $row;

    scalar @nodes == 0
        and die "ERROR: Empty tree\n";

    scalar @nodes >  1
        and die "ERROR: Too many nodes for root\n";

    $nodes[ 0 ] eq $EMPTY
        and die "ERROR: Empty tree\n";

    $tree->[ 0 ][ 0 ] = $nodes[ 0 ];
}

#------------------------------------------------------------------------------
sub add_children
#------------------------------------------------------------------------------
{
    my  ($row, $level, $tree) = @_;

    my   $width = 2 ** $level;
    push @$tree, [ (undef) x $width ];
    my   @nodes = split ' ', $row;
    my   $count = scalar @nodes;

    $count <= $width
       or die "ERROR: Too many nodes ($count) for level $level\n";

    my $col = 0;

    for my $node (@nodes)
    {
        if ($node ne $EMPTY)
        {
            defined $tree->[ $level - 1 ][ int( $col / 2 ) ]
                or die qq[ERROR: Parentless child "$node"\n];

            $tree->[ $level ][ $col ] = $node;
        }

        ++$col;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
        or die "ERROR: Expected 1 command line argument, found $args\n$USAGE";

    my $str_rep =  $ARGV[ 0 ];
       $str_rep =~ s/ ^ \s+   //x;      # Trim initial  whitespace
       $str_rep =~ s/   \s+ $ //x;      # Trim trailing whitespace
       $str_rep =~ s/   \s+   / /gx;    # Remove superfluous whitespace

    return $str_rep;
}

###############################################################################
