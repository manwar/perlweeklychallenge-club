#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @trees;
my $tree;

# Tree 0:
#     8
#    / \
#   5   9
#  / \
# 4   6

$trees[0] = make_tree_node(8);
$trees[0]{l} = make_tree_node(5);
$trees[0]{r} = make_tree_node(9);
$trees[0]{l}{l} = make_tree_node(4);
$trees[0]{l}{r} = make_tree_node(6);


# Tree 1:
#     5
#    / \
#   4   7
#  / \
# 3   6

$trees[1] = make_tree_node(5);
$trees[1]{l} = make_tree_node(4);
$trees[1]{r} = make_tree_node(7);
$trees[1]{l}{l} = make_tree_node(3);
$trees[1]{l}{r} = make_tree_node(6);

for $tree (0 .. $#trees){
    printf(
        "Tree %d is %sa BST\n\n",
        $tree,
        is_BST($trees[$tree]) ? "" : "not "
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a binary tree is a proper Binary Search Tree (BST)
# Takes one argument:
# * A ref to the root node of a binary tree
# Returns:
# * 1 if the tree meets the requirements of a BST
# * 0 if the tree does not meet the requirements of a BST
################################################################################
sub is_BST{
    my $tree = shift();

    return(
        _BST_verification_recursor(
            $tree,
            # Some absurdly large initial
            # min and max values...
            -100000000000000000,
            100000000000000000
        )
    );

}



################################################################################
# Recurse through a binary tree, to determine if it is a proper Binary Search
# Tree (BST)
# Takes three arguments:
# * A ref to a node of the binary tree; it and deeper nodes will be examined
# * The minimum value below which this node will not be considered part of a
#   valid BST
# * The maximum value above which this node will not be considered part of a
#   valid BST
# Returns:
# * 1 if the node and all sub-nodes meet the requirements of a BST
# * 0 if the node or any sub-node does not meet the requirements of a BST
# NOTE: This function should ONLY be called by is_BST(), which does some
# inital setup
################################################################################
sub _BST_verification_recursor{
    my $node = shift();
    my $min = shift();
    my $max = shift();

    # If this node is undef, just
    # return a true value
    return(1) unless($node);

    # If the value of this node is out
    # of established bounds, return
    # false
    return(0) if($node->{d} < $min || $node->{d} > $max);

    # Dig deeper to the left and to
    # the right
    return(0) unless(
        _BST_verification_recursor(
            $node->{l}, $min, $node->{d} - 1
        )
    );
    return(0) unless(
        _BST_verification_recursor(
            $node->{r}, $node->{d} + 1, $max
        )
    );

    return(1);

}



################################################################################
# Make a node for a binary tree
# Takes one argument:
# * A scalar that represents (or points to) the data (D) to store in this node
# Returns:
# * A binary tree node in the form of a hash ref with the data stored therein,
#   and left/right ref fields set to undef, e.g.:
#   {
#       d => D,
#       l => undef,
#       r => undef
#   }
################################################################################
sub make_tree_node{
    my $n = shift();

    return(
        {
            d => $n,
            l => undef,
            r => undef
        }
    );

}



