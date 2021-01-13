#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use Tree::Binary;

# Input
my ($btree) = Tree::Binary
    -> new('1')
    -> setLeft (
      Tree::Binary
        -> new('2')
        -> setLeft(Tree::Binary->new('4'))
    )
    -> setRight (
      Tree::Binary
        -> new('3')
        -> setLeft(Tree::Binary->new('5'))
        -> setRight(Tree::Binary->new('6'))
);


# Output
say (@{sumPath($btree)}[0]);

# Sum path
sub sumPath {
  my ($btree) = @_;
  my $left = $btree -> getLeft;
  my $right = $btree -> getRight;
  my $val = $btree -> getNodeValue;

  return [$val, 1] if(!defined $left && !defined $right);

  my $sum = 0;
  my $leaves = 0;

  if(defined $left) {
    my ($leftSum, $leftLeaves) = @{sumPath($left)};

    $sum += $leftSum + $val * $leftLeaves;
    $leaves += $leftLeaves;
  }

  if(defined $right) {
    my ($rightSum, $rightLeaves) = @{sumPath($right)};

    $sum += $rightSum + $val * $rightLeaves;
    $leaves += $rightLeaves;
  }

  return [$sum, $leaves];
}