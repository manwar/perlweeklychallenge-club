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
      ## Assumption all points lie on integer points in the plane {tbh
      ## if this is not the case the challenge is very difficult as rounding
      ## errors will make it impossible to find truely co-linear points -
      ## so would have to add some "guestimate" coding to work out what is
      ## near enough to "co-linear"...
      ##
      ## Now - if we divide dx by dy we would end up with decimal values for
      ## the slope there may be rounding errors in the storage.
      ##
      ## To remove this potential we can reduce the fraction to it's simplest
      ## form - by dividing numerator and denominator by their greatest
      ## common factor..... {if dx or dy are "0" we just define the "key" to
      ## be two other symbols} We can then store the direction as "int"-"int"
      
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
  return $max+1; ## We will only pick up points co-linear to best point
                 ## - so need to add one to include that point...
}


sub gcd {
  my( $n,$m ) =( abs $_[0], abs $_[1] );   ## m/n may be -ve so have to make sure +ve
  ($n,$m) = ($m,$n) if $m>$n;              ## Make sure m < n as well
  ($n,$m) = ( $m, $n % $m ) while $n % $m; ## Reduces to gcd algorithm we've had before...
  return $m;
}

