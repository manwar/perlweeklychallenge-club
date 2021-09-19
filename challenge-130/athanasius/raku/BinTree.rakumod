use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 130, Task #2: Binary Search Tree

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The BinTree class below is adapted from class BinaryTree used in the solution
to Task #2 of the Perl Weekly Challenge 94.

The implementation of methods is-bst() and !isBST() is adapted from:

    https://en.wikipedia.org/wiki/Binary_search_tree#Verification

=end comment
#==============================================================================

#==============================================================================
unit class BinTree;
#==============================================================================

#------------------------------------------------------------------------------
my class Node
#------------------------------------------------------------------------------
{
    has Int  $.value;
    has Node $.parent is rw;
    has Node $.left   is rw;
    has Node $.right  is rw;
}

has Node $!root;

#------------------------------------------------------------------------------
submethod BUILD( Int:D :$value )
#------------------------------------------------------------------------------
{
    $!root = Node.new( value => $value, parent => Nil,
                       left  => Nil,    right  => Nil );
}

#------------------------------------------------------------------------------
method append-node( UInt:D $depth, UInt:D $sequence, Int:D $value --> Bool:D )
#------------------------------------------------------------------------------
{
    my Node $parent = $!root;
    my UInt $m      = 2 ** $depth;
    my UInt $seq    = $sequence;
    my UInt $level  = $depth;

    while $level > 1
    {
        $m = ($m / 2).Int;

        if $seq < $m
        {
            $parent.left.defined  or return False;
            $parent = $parent.left;
        }
        else
        {
            $parent.right.defined or return False;
            $parent = $parent.right;
            $seq   -= $m;
        }

        --$level;
    }

    my Node $new-node = Node.new( value => $value, parent => $parent,
                                  left  => Nil,    right  => Nil );

    if $seq == 0
    {
        $parent.left  = $new-node;
    }
    else
    {
        $parent.right = $new-node;
    }

    return True;
}

#------------------------------------------------------------------------------
method is-bst( --> Bool:D )
#------------------------------------------------------------------------------
{
    return self!isBST( $!root, -Inf, +Inf );
}

subset Int-or-Inf where Int:D | -Inf | +Inf;

#------------------------------------------------------------------------------
method !isBST
(
    Node         $node,
    Int-or-Inf:D $min,
    Int-or-Inf:D $max
--> Bool:D
)
#------------------------------------------------------------------------------
{
    return True  if !$node.defined;
    return False if  $node.value < $min || $node.value > $max;

    return self!isBST( $node.left,  $min, $node.value - 1 ) &&
           self!isBST( $node.right, $node.value + 1, $max );
}

##############################################################################
