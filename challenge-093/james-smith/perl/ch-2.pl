#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## We represent the tree as a nested array.
## Each "tree" is an arrayref with up to 3 values
##   * value of node {scalar}
##   * left sub-tree {arrayref}
##   * right sub-tree {arrayref}
## note we don't have a right sub-tree without a left subtree.
is( tree_sum( [1,[2,[3],[4]]] ), 13 );
is( tree_sum( [1,[2,[4]],[3,[5],[6]]] ), 26 );

done_testing( );

use Data::Dumper qw(Dumper);

sub tree_sum {
  my ( $node,$sum ) = @_;
  $sum||=0;
  return $node->[0] + $sum if @{$node} < 2; ## We have a leaf so return the sum...
  ## We have a branch - so return the sum foreach branch. for reach branch we need to add
  ## the current value to the sum from ancestors...
  return tree_sum( $node->[1], $node->[0] + $sum ) +
         ( @{$node} == 3 ? tree_sum( $node->[2], $node->[0] + $sum ) : 0 );
}

