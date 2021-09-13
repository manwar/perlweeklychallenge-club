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
  my( $p, @nodes ) = shift->flatten( sub { return $_[0]; }, 'in' );
  ( $nodes[0] < $p ) ? (return 0) : ( $p = shift @nodes ) while @nodes;
  return 1;
}


