#!/usr/bin/perl

use strict;
use warnings;
use Tree::Binary;

# Input
my ($btree) = Tree::Binary
  -> new('1')
  -> setLeft (
    Tree::Binary
      -> new('2')
      -> setLeft(Tree::Binary->new('4'))
      -> setRight (
        Tree::Binary
          -> new('5')
          -> setLeft(Tree::Binary->new('6'))
          -> setRight(Tree::Binary->new('7'))
      )
  )
  -> setRight (Tree::Binary->new('3'));

# Output
printLinkedList(createLinkedList($btree));

# Binary Tree to Linked List
sub createLinkedList {
  my ($btree) = @_;
  my $left = $btree -> getLeft;
  my $right = $btree -> getRight;
  my $res = { 'value' => $btree -> getNodeValue, 'next' => undef };

  if(defined $left || defined $right) {
    my $next = $res;

    if(defined $left) {
      $next->{'next'} = createLinkedList($left);

      $next = $next->{'next'} while(defined $next->{'next'});
    }

    if(defined $right) {
      $next->{'next'} = createLinkedList($right);
    }
  }

  return $res;
}

# Print Linked List
sub printLinkedList {
  my ($next) = @_;

  while(defined $next->{'next'}) {
    print $next->{'value'}." -> ";
    $next = $next->{'next'};
  }

  print $next->{'value'};
}