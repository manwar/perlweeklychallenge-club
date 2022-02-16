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
is( min_path_anydir(       $_->[0] ), $_->[2] ) foreach @TESTS;
is( min_path_total(        $_->[0] ), $_->[1] ) foreach @TESTS;
is( min_path_anydir_total( $_->[0] ), $_->[2] ) foreach @TESTS;

done_testing();

sub min_path {
  my @p = map { [0,[]] } 0,my @t = reverse @{$_[0]};
  @p = map {
         $p[0][0] < $p[1][0]
       ? [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ]
       : [ $_+$p[1][0], [ $_, @{$p[1][1]} ] ],
       (shift @p) x 0
  } @{$_} for @t;
  say sprintf 'Minimum value %d: [ %s ]', $p[0][0], join ', ', @{$p[0][1]};
  $p[0][0];
}

sub min_path_total {
  my @p = map { 0 } 0, my @t = reverse @{$_[0]};
     @p = map { $_ + $p[ $p[0] < $p[1] ? 0 : 1 ], (shift @p)x 0 } @{$_} for @t;
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

sub min_path_anydir_total {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = $_->[0];
    $_ < $min && ($min = $_) for @{$_};
    $res+= $min;
  }
  $res;
}
