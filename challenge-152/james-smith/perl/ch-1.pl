#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ [1], [5,3], [2,3,4], [7,1,0,2], [6,4,5,2,8] ],  9, 8 ],
  [ [ [5], [2,3], [4,1,5], [0,1,2,3], [7,2,4,1,9] ], 11, 9 ],
);

is( min_path(              $_->[0] ), $_->[1] ) foreach @TESTS;
is( min_path_total(        $_->[0] ), $_->[1] ) foreach @TESTS;

is( min_path_anydir(       $_->[0] ), $_->[2] ) foreach @TESTS;
is( min_path_anydir_sort(  $_->[0] ), $_->[2] ) foreach @TESTS;
is( min_path_anydir_total( $_->[0] ), $_->[2] ) foreach @TESTS;
is( min_path_anydir_stot(  $_->[0] ), $_->[2] ) foreach @TESTS;

done_testing();

## For each entry - we store tuple [ total, "path" ].
## We create a "row" below the triangle with "0"s and empty paths...
## We work back up the tree, and for each cell in the row we
## add the left or right sub-tree depending on which has the lowest
## value...

sub min_path {
  my @p = ( [0,[]] ) x (1 + @{$_[0]});
  @p = map { $p[0][0] < $p[1][0] ? [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ] : [ $_+$p[1][0], [ $_, @{$p[1][1]} ] ], (shift @p) x 0 } @{$_} for reverse @{$_[0]};
  say sprintf 'Minimum value %d: [ %s ]', $p[0][0], join ', ', @{$p[0][1]};
  $p[0][0];
}

## Without he tuple containing the total/sequence
sub min_path_total {
  my @p = (0) x (1+@{$_[0]});
     @p = map { $_ + $p[$p[0]<$p[1]?0:1], (shift @p)x 0 } @{$_} for reverse @{$_[0]};
  $p[0];
}

sub min_path_anydir {
  my ($res,@order) = 0;
  foreach(@{$_[0]}) {
    my $min = $_->[0];
    $_<$min && ($min = $_) for @{$_};
    $res+= $min;
    push @order, $min;
  }
  say sprintf 'Minimum value %d: [ %s ]', $res, join ', ', @order;
  $res;
}

## Cheeky "one-liner" version - use sort instead of for loop....
##
## After we have pushed the value we then update the total {which is the last element of order}

sub min_path_anydir_sort {
  my($res,@order)= 0;
  (push @order, [sort {$a<=>$b} @{$_}]->[0]), $res+=$order[-1] for @{$_[0]};
  say sprintf 'Minimum value %d: [ %s ]', $res, join ', ', @order;
  $res;
}

sub min_path_anydir_total {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = $_->[0];
    $_ < $min && ($min = $_) for @{$_};
    $res+= $min;
  }
  $res;
}

## Simpler version of the sort method above which only does total..

sub min_path_anydir_stot {
  my $res=0;
  $res += [sort {$a<=>$b} @{$_}]->[0] for @{$_[0]};
  $res;
}


