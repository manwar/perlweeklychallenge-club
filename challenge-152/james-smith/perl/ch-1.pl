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
  for my $r (@t) {
    my($l,@q) = shift @p;
    ( push @q, $l->[0] < $p[0][0]
       ? [ $_+$l->[0],  [ $_, @{$l->[1]}  ] ]
       : [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ]
    ), $l = shift @p for @{$r};
    @p = @q;
  }
  say sprintf 'Minimum value %d: [ %s ]', $p[0][0], join ', ', @{$p[0][1]};
  $p[0][0];
}

sub min_path_total {
  my @p = map { 0 } 0,my @t = reverse @{$_[0]};
  for my $r (@t) {
    my($l,@q) = shift @p;
    ( push @q, $_ + ( $l < $p[0] ? $l : $p[0] ) ), $l = shift @p for @{$r};
    @p = @q;
  }
  $p[0];
}

sub min_path_anydir {
  my ($res,@order) = 0;
  foreach(@{$_[0]}) {
    my $min = $_[0][0];
    $min = $_ < $min ? $_ : $min for @{$_};
    $res+= $min;
    push @order, $min;
  }
  say sprintf 'Minimum value %d: [ %s ]', $res, join ', ', @order;
  $res;
}

sub min_path_anydir_total {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = $_[0][0];
    $min = $_ < $min ? $_ : $min for @{$_};
    $res+= $min;
  }
  $res;
}
