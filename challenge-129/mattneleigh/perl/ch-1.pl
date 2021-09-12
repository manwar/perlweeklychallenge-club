#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @trees;
my @search_nodes;
my $tree;
my $node;

# Tree 0:
#   1
#  / \
# 2   3
#      \
#       4
#      / \
#     5   6

$trees[0] = make_tree_node(1);
$trees[0]{l} = make_tree_node(2);
$trees[0]{r} = make_tree_node(3);
$trees[0]{r}{r} = make_tree_node(4);
$trees[0]{r}{r}{l} = make_tree_node(5);
$trees[0]{r}{r}{r} = make_tree_node(6);

$search_nodes[0] = [
    6, 5, 2, 4
];


# Tree 1:
#     1
#    / \
#   2   3
#  /     \
# 4       5
#  \     /
#   6   7
#  / \
# 8   9

$trees[1] = make_tree_node(1);
$trees[1]{l} = make_tree_node(2);
$trees[1]{r} = make_tree_node(3);
$trees[1]{l}{l} = make_tree_node(4);
$trees[1]{r}{r} = make_tree_node(5);
$trees[1]{l}{l}{r} = make_tree_node(6);
$trees[1]{r}{r}{l} = make_tree_node(7);
$trees[1]{l}{l}{r}{l} = make_tree_node(8);
$trees[1]{l}{l}{r}{r} = make_tree_node(9);

$search_nodes[1] = [
    7, 8, 6
];

for $tree (0 .. $#trees){
    my @depths = depth_search($trees[$tree], $search_nodes[$tree]);

    print("Tree $tree:\n");
    print("    Node    Depth\n");
    for $node (0 .. $#{$search_nodes[$tree]}){
        printf(
            "    %4d     %4s\n",
            $search_nodes[$tree][$node],
            defined($depths[$node]) ? $depths[$node] : "N/A"
        );
    }
    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the depths at which we find a set of numbers in a binary tree
# Takes two arguments:
# * A ref to the root of the binary tree
# * A ref to an array of numbers to search for
# Returns:
# * A list of depths corresponding to the original search numbers; if a number
#   was not found in the tree, undef will be assigned to the corresponding
#   place in the list
#
# Example:
# Given a tree:
#   1
#  / \
# 2   3
#      \
#       4
#      / \
#     5   6
# a search array:
#   [ 6, 5,    10, 2, 4 ]
# will yield:
#   ( 3, 3, undef, 1, 2 )
#
################################################################################
sub depth_search{
    my $tree = shift();
    my $search_nodes = shift();

    my %output_table;

    # Build an input table with the
    # numbers we're looking for as keys
    # and 1 as the value for each, and
    # search the tree
    _depth_search_recursor(
        $tree,
        { map({ $_ => 1 } @{$search_nodes}) },
        \%output_table,
        0
    );

    # Build and return a list of depths
    # found for each number; if a number
    # wasn't found in the tree, its
    # depth will be reported as undef
    return(map({ $output_table{$_} } @{$search_nodes}));

}



################################################################################
# Recurse through a binary tree, searching for particular numbers and recording
# the depth at which they're found
# Takes four arguments:
# * A ref to a node of the binary tree; it and deeper nodes will be examined
# * A ref to a hash containing the numbers to search for as keys, with 1 as the
#   value for each; each key/value pair will be removed from the hash as its
#   key is found in the tree
# * A ref to a hash that will be populated with found numbers as keys, and the
#   depth at which each was found as values
# * The depth of the current node, as a distance from the root node, which
#   should be 0 on the first call to this function
# Returns undef in all cases, which conveys no meaningful information
# NOTE: This function should ONLY be called by depth_search(), which does some
# inital setup
################################################################################
sub _depth_search_recursor{
    my $node = shift();
    my $input_table = shift();
    my $output_table = shift();
    my $depth = shift();

    # If we're at an undefined node
    # or the input table is empty,
    # just return
    return() unless(defined($node) && %{$input_table});

    if($input_table->{$node->{d}}){
        # This is a node we're looking for-
        # delete it from the input table and
        # make a note of its depth in the
        # output table
        delete($input_table->{$node->{d}});
        $output_table->{$node->{d}} = $depth;
    }

    # Dig deeper to the left and to
    # the right
    _depth_search_recursor(
        $node->{l}, $input_table, $output_table, $depth + 1
    );
    _depth_search_recursor(
        $node->{r}, $input_table, $output_table, $depth + 1
    );

    return();

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



