#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use lib '.';
use Tree;
use BinaryTree;

my $x = Tree->new(1)->add_child(
          Tree->new(2)->add_child(
            Tree->new(4)->add_child( Tree->new(7) )
          )
        )->add_child(
          Tree->new(3)->add_child( Tree->new(5))->add_child( Tree->new(6) )
        );


## Clone $x into $y
my $clone = { 'total' => 0 };
my $local;

## Generate clone of $x, and compute the total of all the nodes...
## These will be stored as { 'tree' => OBJECT, 'total' => INT }
## in $global, $x->walk does a "pre-order" traversal of the tree.

$x->walk( sub { my( $node, $global, $local ) = @_;
  $global->{'total'} += $node->[0];
  if(exists $global->{'tree'}) {
    my $child = Tree->new( $node->[0] );
    $local->add_child( $child );
    return $child;
  }
  $global->{'tree'} = Tree->new( $node->[0] );
  return $global->{'tree'};
}, $clone  );

my $y = $clone->{'tree'};
say '';
say 'Dump $x';
$x->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $y, '  ' );
say '';
say 'Dump $y (clone of $x)';
$y->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $y, '  ' );
say '';
say 'Now get total value and adjust each node... for $y';
$y->walk( sub { my( $node, $global         ) = @_; $node->[0] = $global->{'total'} - $node->[0];           }, $clone );
say '';
say 'Dump $y (clone of $x)';
$y->walk( sub { my( $node, $global, $local ) = @_; say $local||='', '> ', $node->[0]; return $local.='  '; }, $y, '  ' );
say '';

say 'Running tests';
is( "@{[ $x->flatten ]}", '1 2 4 7 3 5 6' );
is( "@{[ $y->flatten ]}", '27 26 24 21 25 23 22' );
say '';

$x = BinaryTree->new(1)->add_child_left(
          BinaryTree->new(2)->add_child_left(
            BinaryTree->new(4)->add_child_right( BinaryTree->new(7) )
          )
        )->add_child_right(
          BinaryTree->new(3)->add_child_left( BinaryTree->new(5))->add_child_right( BinaryTree->new(6) )
        );


## Generate clone of $x, and compute the total of all the nodes...
## These will be stored as { 'tree' => OBJECT, 'total' => INT }
## in $global, $x->walk does a "pre-order" traversal of the tree.

## You will need to look more at BinaryTree.pm to see how all methods
## work - clone & dump are implemented using "walk" to walk the tree
## to save writing another tree walker!

$y;


say '';
say 'Dump $x';
$x->dump( sub { "[$_[0]]"; } );
say '';
say 'Clone $x as $y';
$y = $x->clone;
say 'Dump $y (clone of $x)';
$y->dump( sub { "[$_[0]]"; } );
say '';
say 'Now get total value and adjust each node... for $y';
my $glob = { 'total' => 0 };
$y->walk( sub { my( $node, $global ) = @_; $global->{'total'} += $node->[0];             }, $glob );
$y->walk( sub { my( $node, $global ) = @_; $node->[0] = $global->{'total'} - $node->[0]; }, $glob );
say '';
say 'Dump $y (clone of $x)';
$y->dump( sub { "[$_[0]]"; } );
say '';

say 'Running tests';
is( "@{[ $x->flatten ]}", '1 2 4 7 3 5 6' );
is( "@{[ $y->flatten ]}", '27 26 24 21 25 23 22' );
done_testing();
say '';

