#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/         #
#                                                                         #
# Path Sum                                                                #
# You are given a binary tree and a sum, write a script to find if        #
# the tree has a path such that adding up all the values along the path   #
# equals the given sum. Only complete paths (from root to leaf node) may  #
# be considered for a sum.                                                #
#                                                                         #
# Example                                                                 #
# Given the below binary tree and sum = 22,                               #
#                                                                         #
#             5                                                           #
#            / \                                                          #
#           4   8                                                         #
#          /   / \                                                        #
#         11  13  9                                                       #
#        /  \      \                                                      #
#       7    2      1                                                     #
#                                                                         #
# For the given binary tree, the partial path sum 5 -> 8 -> 9 = 22 is     #
# not valid.                                                              #
# The script should return the path 5 -> 4 -> 11 -> 7 whose sum is 22     #
#                                                                         #
###########################################################################

use strict;
use warnings;

use Tree::Binary;

my($btree) = Tree::Binary -> new('5')
    -> setLeft(
        Tree::Binary -> new('4')
              -> setLeft (
                  Tree::Binary -> new('11')
                        -> setLeft (Tree::Binary -> new('7'))
                        -> setRight(Tree::Binary -> new('2'))
                  )
    )
    -> setRight (
        Tree::Binary -> new('8')
              -> setLeft (Tree::Binary -> new('13'))
              -> setRight (
                      Tree::Binary -> new('9')
                            -> setRight (
                                Tree::Binary -> new('1'))
                 )
             );

my @branchMemory = ();
my $k = 22;
my $match = 0;
my $toLeafSum = 0;

$btree -> traverse
    (
        sub
            {
                my($tree) = @_;
                $toLeafSum += $tree -> getNodeValue;

                if ( $tree -> hasLeft and $tree -> hasRight ) {
                    push @branchMemory, $toLeafSum;
                }

                if ( $tree->isLeaf) {
                    ++$match if $toLeafSum == $k;
                    $toLeafSum = pop @branchMemory;
                }
          });

if ($match == 0 ) {
    print "No branch equals $k\n";
} elsif ($match == 1) {
    print "1 branch equals $k\n";
} else {
    print "$match branches equal $k\n";
}

__END__
output:

1 branch equals 22
