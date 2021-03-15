#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw(say);
use Tree::Binary;

=head2

TASK #2 › Binary Tree to Linked List
Submitted by: Mohammad S Anwar
You are given a binary tree.

Write a script to represent the given binary tree as an object and flatten it to a linked list object. Finally print the linked list object.

Example:
    Input:

        1
       / \
      2   3
     / \
    4   5
       / \
      6   7

    Output:

        1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

=cut

my($btree) = Tree::Binary->new('1')->setLeft( Tree::Binary->new('2')->setLeft(Tree::Binary->new('4'))->setRight(Tree::Binary->new('5')->setLeft(Tree::Binary->new('6'))->setRight( Tree::Binary->new('7') ) ))->setRight(Tree::Binary->new('3'));

$btree->traverse
(
  sub
  {
    my($tree) = @_;
    print " -> " unless $tree->isRoot;
    print $tree->getNodeValue;
  }
);

print "\n";

__END__

perl ch-2.pl
1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3


