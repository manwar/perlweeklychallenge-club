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
      my $dir = '-';
      my( $dx,$dy) = ( $nodes[$i][0]-$nodes[$j][0], $nodes[$i][1]-$nodes[$j][1] );
      if( $dx && $dy ) {
        my $gcd = gcd( $dx,$dy );
        $dir = $dx/$gcd.'-'.$dy/$gcd;
      } else {
        $dir = $dx ? '-' : '|';
      }
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


sub gcd {
  my( $n,$m,$s ) = (@_,1);
  ($n,$m) = (-$n,-$m) if $n < 0;
  if( $m < 0 ) {
    $s = -1;
    $m = -$m;
  }
  ($n,$m) = ($m,$n) if $m>$n;
  ($n,$m) = ( $m, $n % $m ) while $n % $m;
  return $m*$s;
}

