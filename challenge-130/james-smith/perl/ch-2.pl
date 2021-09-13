#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use lib '.';
use BinaryTree;

my $T1 = BinaryTree->new(8)->add_child_left(
           BinaryTree->new(5)->add_child_left(BinaryTree->new(4))->add_child_right(BinaryTree->new(6))
         )->add_child_right( BinaryTree->new(9)
         );
my $T2 = BinaryTree->new(5)->add_child_left(
           BinaryTree->new(4)->add_child_left(BinaryTree->new(3))->add_child_right(BinaryTree->new(6))
         )->add_child_right( BinaryTree->new(7)
         );
my @TESTS = (
  [ $T1, 1 ],
  [ $T2, 0 ],
);

is( is_bst($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_bst {
  my $tree = shift;
  return 1 unless $tree->has_left || $tree->has_right; ## Trivial solution no children...
  return 0 if $tree->has_left && ( max_value($tree->left)> $tree->value ||
                                         ! is_bst( $tree->left) );
  return 0 if $tree->has_right && ( min_value($tree->right)<$tree->value ||
                                         ! is_bst( $tree->right) );
  return 1;
}

sub max_value {
  my $tree = shift;
  my $max = $tree->value;
  if( $tree->has_left ) {
    my $t = max_value( $tree->left );
    $max = $t if $t > $max;
  }
  if( $tree->has_right ) {
    my $t = max_value( $tree->right );
    $max = $t if $t > $max;
  }
  return $max;
}

sub min_value {
  my $tree = shift;
  my $min = $tree->value;
  if( $tree->has_left ) {
    my $t = min_value( $tree->left );
    $min = $t if $t < $min;
  }
  if( $tree->has_right ) {
    my $t = min_value( $tree->right );
    $min = $t if $t < $min;
  }
  return $min;
}

