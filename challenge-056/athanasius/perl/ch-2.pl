#!perl

################################################################################
=comment

Perl Weekly Challenge 056
=========================

Task #2
-------
*Path Sum*

You are given a binary tree and a sum, write a script to find if the tree has a
path such that adding up all the values along the path equals the given sum.
Only complete paths (from root to leaf node) may be considered for a sum.

*Example*

Given the below binary tree and sum = 22,

          5
         / \
        4   8
       /   / \
      11  13  9
     /  \      \
    7    2      1

For the given binary tree, the partial path sum *5 → 8 → 9 = 22* is *not* valid.

The script should return the path *5 → 4 → 11 → 2* whose sum is *22*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
# Assumptions:
#
# (1) All tree values are positive numbers greater than zero.
#     This simplifies the search, because it means that searching a path can be
#     safely discontinued as soon as the path sum becomes >= the target sum.
#
# (2) If multiple solutions exist, only the first (via depth-first traversal) is
#     required.
#-------------------------------------------------------------------------------

use strict;
use warnings;
use Const::Fast;
use Tree::Binary2;
use constant DEBUG => 0;

const my $SUM => 22;

my @path;
my $solution_found;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 056, Task #2: Path Sum (Perl)\n\n";

    my $tree = populate_tree();

    if (DEBUG)
    {
        # The example tree's mirror (i.e., all nodes reversed) is a better test
        # of the algorithm because the invalid solution 5 -> 8 -> 9 is examined
        # BEFORE the correct solution 5 -> 4 -> 11 -> 2

        $tree->mirror;

        printf "%s\n\n", join "\n",
                              @{ $tree->tree2string({ no_attributes => 1 }) };
    }

    find_path($tree, $SUM);

    if ($solution_found)
    {
        printf "Found path: %s, whose sum is %d\n", join(' -> ', @path), $SUM; 
    }
    else
    {
        print  "No path found for sum $SUM\n";
    }
}

#-------------------------------------------------------------------------------
# See the Wikipedia article "Backtracking", section "Pseudocode"
#
sub find_path
#-------------------------------------------------------------------------------
{
    my ($tree, $sum) = @_;

    return if $solution_found;

    my $root = $tree->{ _value };

    push @path, $root;

    if ($root > $sum)
    {
        pop @path;
        return;
    }

    my $left  = $tree->left;
    my $right = $tree->right;

    if ($root == $sum)
    {
        if (!$left && !$right)      # Leaf node
        {
            $solution_found = 1;
        }
        else                        # Internal node
        {
            pop @path;
        }

        return;
    }

    find_path($left,  $sum - $root) if $left;       # Recursive calls
    find_path($right, $sum - $root) if $right;

    pop @path unless $solution_found;
}

#-------------------------------------------------------------------------------
sub populate_tree
#-------------------------------------------------------------------------------
{
    my $tree  = Tree::Binary2->new( 5 );
    my $left  = Tree::Binary2->new( 4 );
    my $right = Tree::Binary2->new( 8 );

    $tree->left(  $left  );
    $tree->right( $right );

    $left = Tree::Binary2->new( 11 );
    $tree->left->left( $left );

    $left  = Tree::Binary2->new( 7 );
    $right = Tree::Binary2->new( 2 );

    $tree->left->left->left(  $left  );
    $tree->left->left->right( $right );

    $left  = Tree::Binary2->new( 13 );
    $right = Tree::Binary2->new(  9 );

    $tree->right->left(  $left  );
    $tree->right->right( $right );

    $right = Tree::Binary2->new( 1 );

    $tree->right->right->right( $right );

    return $tree;
}

################################################################################
