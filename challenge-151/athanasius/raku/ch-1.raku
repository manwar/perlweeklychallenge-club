use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Output
------
The output is the minimum depth of any leaf node (see "Note on Tree Depth"
below). In addition, if $VERBOSE is set to True (the default), the value/name
of that leaf node is also shown.

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

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;
my Str  constant $EMPTY   = '*';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 151, Task #1: Binary Tree Depth (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $binary-tree     #= String: "|" separates levels, "*" = an empty node
)
#==============================================================================
{
    my Str $str-rep =  $binary-tree;
           $str-rep ~~ s/ ^ \s+   //;      # Trim initial  whitespace
           $str-rep ~~ s/   \s+ $ //;      # Trim trailing whitespace
           $str-rep ~~ s:g/ \s+   / /;     # Remove superfluous whitespace

    qq[Input: "$str-rep"].put;

    my Array[Str] @tree = build-tree( $str-rep );

    # Perform a level-order walk (breadth-first search) of the tree until the
    # first leaf node is found

    L-OUTER:
    for 0 .. @tree.end -> UInt $level
    {
        for 0 .. @tree[ $level ].end -> UInt $index
        {
            my Str $node = @tree[ $level ][ $index ];

            if $node.defined
            {
                if   $level == @tree.end ||
                   (!@tree[ $level + 1 ][ 2 * $index     ].defined &&
                    !@tree[ $level + 1 ][ 2 * $index + 1 ].defined)
                {
                    qq[Output: %d\n].printf: $level + 1;
                    qq[\nThe first leaf node is "$node"].put if $VERBOSE;

                    last L-OUTER;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub build-tree( Str:D $str-rep --> Array:D[Array:D[Str]] )
#------------------------------------------------------------------------------
{
    my Str        @rows      = $str-rep.split: '|', :skip-empty;
    my Str        $first-row = @rows.shift;
    my Array[Str] @tree;

    @tree.push: Array[Str].new: Nil;

    add-root( $first-row, @tree );

    my UInt $level = 1;

    for @rows -> Str $row
    {
        add-children( $row, $level, @tree );

        ++$level;
    }

    return @tree;
}

#------------------------------------------------------------------------------
sub add-root( Str:D $row, Array:D[Array:D[Str]] $tree )
#------------------------------------------------------------------------------
{
    !$row.defined || $row eq ''
        and error( 'Empty tree' );

    my Str @nodes = $row.split: / \s+ /, :skip-empty;

    +@nodes == 0
        and error( 'Empty tree' );

    +@nodes >  1
        and error( 'Too many nodes for root' );

    @nodes[ 0 ] eq $EMPTY
        and error( 'Empty tree' );

    $tree[ 0 ][ 0 ] = @nodes[ 0 ];
}

#------------------------------------------------------------------------------
sub add-children( Str:D $row, UInt:D $level, Array:D[Array:D[Str]] $tree )
#------------------------------------------------------------------------------
{
    my UInt $width = 2 ** $level;

    $tree.push: Array[Str].new: Nil xx $width;

    my Str  @nodes = $row.split: / \s+ /, :skip-empty;

    +@nodes <= $width
       or error( "Too many nodes ({ +@nodes }) for level $level\n" );

    my UInt $col = 0;

    for @nodes -> Str $node
    {
        if $node ne $EMPTY
        {
            $tree[ $level - 1 ][ ( $col / 2 ).floor ].defined
                or error( qq[Parentless child "$node"\n] );

            $tree[ $level ][ $col ] = $node;
        }

        ++$col;
    }
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    exit;
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
