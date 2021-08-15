#!/usr/bin/perl

use strict;
use warnings;
use Scalar::Util qw(reftype);

################################################################################
# Begin main execution
################################################################################

my @trees;

# Tree 0:
#
#     1
#    / \
#   2   5
#  / \ / \
# 3  4 6  7
#        / \
#       8  10
#      /
#     9

$trees[0] = make_tree_node(1);
$trees[0]{l} = make_tree_node(2);
$trees[0]{l}{l} = make_tree_node(3);
$trees[0]{l}{r} = make_tree_node(4);
$trees[0]{r} = make_tree_node(5);
$trees[0]{r}{l} = make_tree_node(6);
$trees[0]{r}{r} = make_tree_node(7);
$trees[0]{r}{r}{l} = make_tree_node(8);
$trees[0]{r}{r}{l}{l} = make_tree_node(9);
$trees[0]{r}{r}{r} = make_tree_node(10);


# Tree 1 (for testing- diameter does not
# pass through the root node):
#
#     1
#    / \
#   2   3
#      / \
#     4   7
#    /     \
#   5       8
#  /         \
# 6           9
#              \
#              10

$trees[1] = make_tree_node(1);
$trees[1]{l} = make_tree_node(2);
$trees[1]{r} = make_tree_node(3);
$trees[1]{r}{l} = make_tree_node(4);
$trees[1]{r}{l}{l} = make_tree_node(5);
$trees[1]{r}{l}{l}{l} = make_tree_node(6);
$trees[1]{r}{r} = make_tree_node(7);
$trees[1]{r}{r}{r} = make_tree_node(8);
$trees[1]{r}{r}{r}{r} = make_tree_node(9);
$trees[1]{r}{r}{r}{r}{r} = make_tree_node(10);

my $tree;
my $diameter;
my $path;
my @node_IDs;

# Loop over each tree and find the longest
# path between leaves in each
foreach $tree (@trees){
    @node_IDs = ();
    ($diameter, $path) = calculate_tree_diameter_path($tree);
    printf("Diameter: $diameter\n");
    foreach(@{$path}){
        push(@node_IDs, $_->{d});
    }
    printf("Path: %s\n", join(", ", @node_IDs));
    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the diameter- the greatest distance between two leaves- of a binary
# tree
# Takes one argument:
# * A ref to the root of a binary tree, the nodes of which must consist of hash
#   references with references to further nodes to the left and right in fields
#   named 'l' and 'r' respectively, e.g.:
#
#   {
#       d => $data, # This will be ignored
#       l => undef,
#       r => undef
#   }
#
# Returns:
# * A list containing the number of nodes between (and including) the two
#   farthest leaves in the tree, and a ref to a list of node refs that describe
#   the path between said leaves, including the leaves and the root of the
#   subtree through which the diameter passes, which may or may not be the root
#   of the tree provided, e.g.:
#
#   ($diameter, $path) = calculate_tree_diameter_path($tree);
#
################################################################################
sub calculate_tree_diameter_path{
    my $tree = shift();

    my $diameter_data = {
        diameter => 0,
        root => undef,
        r_path => undef,
        l_path => undef
    };

    # Traverse the tree; we ignore the return
    # values since what we want is all in
    # $diameter_data
    calculate_max_tree_depth($tree, $diameter_data);

    # Combine the left-path list, root node, 
    # and right-path list from the subtree we
    # found, reversing the order of the latter
    # en passant to create a proper leaf-to-leaf
    # path through the root node
    push(@{$diameter_data->{l_path}}, $diameter_data->{root});
    while(scalar(@{$diameter_data->{r_path}})){
        push(
            @{$diameter_data->{l_path}},
            pop(@{$diameter_data->{r_path}})
        );
    }

    return(
        $diameter_data->{diameter},
        $diameter_data->{l_path}
    );

}



################################################################################
# Calculate the maximum depth- the distance to the farthest leaf- of a binary
# tree
# Takes two arguments:
# * A ref to the root of a binary tree, the nodes of which must consist of hash
#   references with references to further nodes to the left and right in fields
#   named 'l' and 'r' respectively, e.g.:
#
#   {
#       d => $data, # This will be ignored
#       l => undef,
#       r => undef
#   }
#
# * A ref to a hash that, if defined, will be used to store details of the
#   tree's diameter (the longest path between two leaves) which may not
#   necessarily pass through the root node.  The hash should be initialized as
#   follows, with all fields required:
#
#   {
#       diameter => 0,   # Diameter of the tree including both leaves and the
#                        # root node of the subtree that includes the diameter
#       root => undef,   # Ref to the root node of the subtree that includes
#                        # the diameter
#       l_path => undef, # Ref to a list of node refs along the path of the
#                        # diameter to the left, including the leaf but NOT the
#                        # root
#       r_path => undef  # Ref to a list of node refs along the path of the
#                        # diameter to the right, including the leaf but NOT
#                        # the root
#   }
#
#   All fields will be populated with the appropriate data upon this function's
#   return; if this information is not desired, 'undef' may be passed as the
#   second argument
# Returns:
# * A list containing the number of nodes between (and including) the specified
#   root and the farthest leaf, and a ref to a list of node refs that describe
#   the path to the farthest leaf, including the leaf but NOT the root, e.g.:
#
#   ($depth, $path) = calculate_max_tree_depth($tree, \%diameter);
#
#   or
#
#   ($depth, $path) = calculate_max_tree_depth($tree, undef);
#
################################################################################
sub calculate_max_tree_depth{
    my $root = shift();

    unless($root){
        # No nodes in this direction;
        # return zero length and empty
        # path
        return(0, []);
    }

    my $diameter_data = shift();

    my $l_depth;
    my $l_path;
    my $r_depth;
    my $r_path;

    # Dig deeper to the left, and to the
    # right
    ($l_depth, $l_path) =
        calculate_max_tree_depth($root->{l}, $diameter_data);
    ($r_depth, $r_path) =
        calculate_max_tree_depth($root->{r}, $diameter_data);

    # reftype() taken from Scalar::Util
    if($diameter_data && (reftype($diameter_data) eq "HASH")){
        # We're keeping track of the largest
        # leaf-to-leaf distance; if the diameter at
        # this node is the largest we've seen so
        # far, store the data we have at this point
        my $node_diameter = $l_depth + $r_depth + 1;

        if($node_diameter > $diameter_data->{diameter}){
            $diameter_data->{diameter} = $node_diameter;
            $diameter_data->{root} = $root;
            $diameter_data->{l_path} = copy_list($l_path);
            $diameter_data->{r_path} = copy_list($r_path);
        }
    }

    # Check which side had the deeper path,
    # and return it
    if($r_depth > $l_depth){
        push(@{$r_path}, $root);
        return($r_depth + 1, $r_path);
    } else{
        push(@{$l_path}, $root);
        return($l_depth + 1, $l_path);
    }

}



################################################################################
# Make a copy of a list
# Takes one argument:
# * A ref to the list to copy- the source list
# Returns on success:
# * A ref to a copy of the source list; if the source list is empty, this will
#   be empty as well
# Returns on error:
# * undef if the source list reference is undefined
# NOTE: This function only copies the source list itself; if that list contains
# refs to other data structures, only the refs are copied
################################################################################
sub copy_list{
    my $source = shift();

    my $dest = [];

    unless(defined($source)){
        return(undef);
    }

    foreach(@{$source}){
        push(@{$dest}, $_);
    }

    return($dest);

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



