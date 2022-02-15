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

is( min_path(       $_->[0]), $_->[1] ) foreach @TESTS;
is( min_path_anydir($_->[0]), $_->[2] ) foreach @TESTS;

done_testing();

sub min_path {
  my @p = map { [0,[]] } 0,my @t = reverse @{$_[0]};
  for my $r (@t) {
    my($l,@q,$z) = shift @p;
    ( push @q, $l->[0] < $p[0][0]
       ? [ $_+$l->[0],  [ $_, @{$l->[1]}  ] ]
       : [ $_+$p[0][0], [ $_, @{$p[0][1]} ] ]
    ), $l = shift @p for @{$r};
    @p = @q;
  }
  $p[0][0];
}

sub min_path_anydir {
  my $res = 0;
  foreach(@{$_[0]}) {
    my $min = 1e99;
    $min = $_ < $min ? $_ : $min for @{$_};
    $res+= $min;
  }
  $res;
}
