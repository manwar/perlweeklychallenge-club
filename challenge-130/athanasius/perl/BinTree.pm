#!perl

###############################################################################
=comment

Perl Weekly Challenge 130, Task #2: Binary Search Tree

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The BinTree class below is adapted from class BinaryTree used in the solution
to Task #2 of the Perl Weekly Challenge 94.

The implementation of method is_bst() and sub _isBST() is adapted from:

    https://en.wikipedia.org/wiki/Binary_search_tree#Verification

=cut
#==============================================================================

#==============================================================================
package BinTreeNode;
#==============================================================================

#------------------------------------------------------------------------------
sub new                                                           # Constructor
#------------------------------------------------------------------------------
{
    my ($class, $value, $parent) = @_;

    my  %self = ( value => $value, parent => $parent,
                  left  => undef,  right  => undef );

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub value                                                         # Getter only
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{value};
}

#------------------------------------------------------------------------------
sub parent                                                      # Getter/setter
#------------------------------------------------------------------------------
{
    my ($self, $new_parent) = @_;

    if (defined $new_parent)
    {
        $self->{parent} = $new_parent;
    }

    return $self->{parent};
}

#------------------------------------------------------------------------------
sub left                                                        # Getter/setter
#------------------------------------------------------------------------------
{
    my ($self, $new_left) = @_;

    if (defined $new_left)
    {
        $self->{left} = $new_left;
    }

    return $self->{left};
}

#------------------------------------------------------------------------------
sub right                                                       # Getter/setter
#------------------------------------------------------------------------------
{
    my ($self, $new_right) = @_;

    if (defined $new_right)
    {
        $self->{right} = $new_right;
    }

    return $self->{right};
}

#==============================================================================
package BinTree;
#==============================================================================

#------------------------------------------------------------------------------
sub new                                                           # Constructor
#------------------------------------------------------------------------------
{
    my ($class, $value) = @_;

    my  %self = ( root => BinTreeNode->new( $value ) );

    return bless \%self, $class;
}

#------------------------------------------------------------------------------
sub root                                                          # Getter only
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{root};
}

#------------------------------------------------------------------------------
sub append_node
#------------------------------------------------------------------------------
{
    my ($self, $depth, $sequence, $value) = @_;

    my  $parent = $self->root;
    my  $m      = 2 ** $depth;
    my  $seq    = $sequence;
    my  $level  = $depth;

    while ($level > 1)
    {
        $m /= 2;

        if ($seq < $m)
        {
            defined   $parent->left  or return 0;
            $parent = $parent->left;
        }
        else
        {
            defined   $parent->right or return 0;
            $parent = $parent->right;
            $seq   -= $m;
        }

        --$level;
    }

    my $new_node = BinTreeNode->new( $value, $parent );

    if ($seq == 0)
    {
        $parent->left(  $new_node );
    }
    else
    {
        $parent->right( $new_node );
    }

    return 1;
}

use POSIX qw( INT_MIN INT_MAX );

#------------------------------------------------------------------------------
sub is_bst
#------------------------------------------------------------------------------
{
    my ($self) = @_;

    return _isBST( $self->root, INT_MIN, INT_MAX );
}

#------------------------------------------------------------------------------
sub _isBST                                                       # Not a method
#------------------------------------------------------------------------------
{
    my ($node, $min, $max) = @_;

    return 1 if !defined $node;
    return 0 if  $node->value < $min || $node->value > $max;

    return _isBST( $node->left,  $min, $node->value - 1 ) &&
           _isBST( $node->right, $node->value + 1, $max );
}

##############################################################################
1;
##############################################################################
