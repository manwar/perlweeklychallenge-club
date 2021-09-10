#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);
use lib '.';
use BinaryTree;

my $node_1_6 = BinaryTree->new( 6 );
my $node_1_5 = BinaryTree->new( 5 );
my $node_1_4 = BinaryTree->new( 4 )->add_child_left( $node_1_5 )->add_child_right( $node_1_6 );
my $node_1_2 = BinaryTree->new( 2 );

my $tree_1 = BinaryTree->new(1)->add_child_left( $node_1_2 )
                ->add_child_right( BinaryTree->new( 3 )->add_child_right( $node_1_4 ) );

my $node_2_8 = BinaryTree->new( 8 );
my $node_2_6 = BinaryTree->new( 6 )->add_child_left( $node_2_8 )
                                   ->add_child_right( BinaryTree->new( 9 ) );
my $node_2_7 = BinaryTree->new( 7 );

my $tree_2 = BinaryTree->new(1)->add_child_left(
               BinaryTree->new(2)->add_child_left(
                 BinaryTree->new(4)->add_child_right( $node_2_6 )
               )
             )->add_child_right(
               BinaryTree->new(3)->add_child_right(
                 BinaryTree->new(5)->add_child_left( $node_2_7 )
               )
             );

my @TESTS = (
  [ $node_1_6, 3 ],
  [ $node_1_5, 3 ],
  [ $node_1_2, 1 ],
  [ $node_1_4, 2 ],
  [ $node_2_7, 3 ],
  [ $node_2_8, 4 ],
  [ $node_2_6, 3 ],
);

is( root_distance($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub root_distance {
  scalar shift->ancestors;
}

