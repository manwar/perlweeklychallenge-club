use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 094, Task #2: Binary Tree to Linked List

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
unit class BinaryTree;
#==============================================================================

#------------------------------------------------------------------------------
my class Node
#------------------------------------------------------------------------------
{
    has Any  $.value;
    has Node $.parent is rw;
    has Node $.left   is rw;
    has Node $.right  is rw;
}

has Node $!root;

#------------------------------------------------------------------------------
submethod BUILD( Any:D :$value )
#------------------------------------------------------------------------------
{
    $!root = Node.new( value => $value, parent => Nil,
                       left  => Nil,    right  => Nil );
}

#------------------------------------------------------------------------------
method append-node( UInt:D $depth, UInt:D $sequence, Str:D $value --> Bool:D )
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
method traverse-preorder( Callable:D $visit )
#------------------------------------------------------------------------------
{
    if $!root.defined
    {
        preorder( $!root, $visit );
    }
}

#------------------------------------------------------------------------------
sub preorder( Node:D $node, Callable:D $visit )
#------------------------------------------------------------------------------
{
    $visit( $node.value );

    preorder( $node.left,  $visit ) if $node.left\.defined;
    preorder( $node.right, $visit ) if $node.right.defined;
}

##############################################################################
