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
is( most_points_in_line( [1,1],[2,2],[3,3]             ), 3 );
is( most_points_in_line( [1,1],[2,2],[3,1],[1,3],[5,3] ), 3 );

done_testing( );

use Data::Dumper qw(Dumper);

sub most_points_in_line {
  my @nodes = @_;
  my %lines;
  foreach my $i (0..(@nodes-2)) {
    foreach my $j (($i+1)..(@nodes-1)) {
      my $dir = $nodes[$i][1] == $nodes[$j][1]
              ? '-'
              :  ($nodes[$i][0]-$nodes[$j][0])/($nodes[$i][1]-$nodes[$j][1]);
      $lines{$i.':'.$dir}++;
      $lines{$j.':'.$dir}++;
    }
  }
  my $max = 0;
  foreach (values %lines) {
    $max = $_ if $_ > $max;
  }
  return $max+1;
}

