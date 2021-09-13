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
  my $tr = shift;
  return ( $tr->has_left  && ( max($tr->left)  > $tr->value || ! is_bst( $tr->left ) ) )
      || ( $tr->has_right && ( min($tr->right) < $tr->value || ! is_bst( $tr->right) ) )
       ? 0 : 1;
}

sub max {
  my $tr = shift;
  my $m = $tr->value;
  if( $tr->has_left  ) { my $t = max( $tr->left );  $m = $t if $t > $m; }
  if( $tr->has_right ) { my $t = max( $tr->right ); $m = $t if $t > $m; }
  return $m;
}

sub min {
  my $tr = shift;
  my $m = $tr->value;
  if( $tr->has_left  ) { my $t = min( $tr->left  ); $m = $t if $t < $m; }
  if( $tr->has_right ) { my $t = min( $tr->right ); $m = $t if $t < $m; }
  return $m;
}


