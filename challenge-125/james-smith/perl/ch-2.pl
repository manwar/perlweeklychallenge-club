#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib '.';
use BinaryTree;

say '';

## Node has both left and right trees - the diameter is 1 + depth of the two child trees.

## 1 -> 2 -> 3
##   |    `> 4
##   `> 5 -> 6
##        `> 7 -> 8 -> 9           [ depth 5 ]
##             `> 10
## -------------------------------
## 9 -> 8 -> 7 -> 5 -> 1 -> 2 -> 3 [ diameter 7 ]

my $x = BinaryTree->new(1)->add_child_left(
          BinaryTree->new(2)->add_child_left( BinaryTree->new(3) )->add_child_right( BinaryTree->new(4) )
        )->add_child_right(
          BinaryTree->new(5)->add_child_left( BinaryTree->new(6))->add_child_right(
            BinaryTree->new(7)->add_child_left( BinaryTree->new(8)->add_child_left(BinaryTree->new(9)) )->add_child_right(BinaryTree->new(10))
        ));
say '1) Tree with root node having both left and right children!';
$x->dump;
say sprintf 'Max depth: %d, diameter %d', $x->depth, $x->diameter;
say '';
## No node has 2 children - the diameter is the depth...

## 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 [ depth 7 ]
## -------------------------------
## 7 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 [ diameter 7 ]
$x = BinaryTree->new(1)->add_child_left(
       BinaryTree->new(2)->add_child_left(
         BinaryTree->new(3)->add_child_right(
           BinaryTree->new(4)->add_child_left(
             BinaryTree->new(5)->add_child_right(
               BinaryTree->new(6)->add_child_left(
                 BinaryTree->new(7)
     ))))));

say '2) Tree with no node having two children';
$x->dump;
say sprintf 'Max depth: %d, diameter %d', $x->depth, $x->diameter;
say '';
## We have a node with two children - but there is a sequence of nodes
## leading up to this node which is longer than the depth of the child trees.
## so diameter is just depth.

## 1 -> 2 -> 3 -> 4 -> 5 -> 6 [ depth 6]
##                  `> 7 -> 8
## --------------------------
## 6 -> 5 -> 4 -> 3 -> 2 -> 1 [ diameter 6 ]
$x = BinaryTree->new(1)->add_child_left(
          BinaryTree->new(2)->add_child_left(
            BinaryTree->new(3)->add_child_left(
              BinaryTree->new(4)->add_child_left(
                BinaryTree->new(5)->add_child_left( BinaryTree->new(6) )
              )->add_child_right(
                BinaryTree->new(7)->add_child_left( BinaryTree->new(8) )
              )
     )));

say '3) Tree with node further down having two children - but distance from';
say '   root to node is greater than the depth of either child';
$x->dump;
say sprintf 'Max depth: %d, diameter %d', $x->depth, $x->diameter;
say '';

## This time both child trees have depths longer than the number of
## ancestor nodes - so that is used to get the length...

## 1 -> 2 -> 3 -> 4      [ depth 4]
##        `> 5 -> 6
## ---------------------
## 6 -> 5 -> 2 -> 3 -> 4 [ diameter 5 ]

say '4) Tree with node further down having two children - but distance from';
say '   root to node is less than the depth of both children';
$x = BinaryTree->new(1)->add_child_left(
       BinaryTree->new(2)->add_child_left(
         BinaryTree->new(3)->add_child_left( BinaryTree->new(4) )
       )->add_child_right(
         BinaryTree->new(5)->add_child_left( BinaryTree->new(6) )
       )
    );

$x->dump;
say sprintf 'Max depth: %d, diameter %d', $x->depth, $x->diameter;
say '';
