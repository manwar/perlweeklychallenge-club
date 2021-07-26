#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ [10,20],[20,20],[20,10],[10,10] ], 1 ],
  [ [ [12,24],[16,10],[20,12],[18,16] ], 0 ],
  [ [ [-2,5],[2,-5],[5,2],[-5,-2] ], 1 ],
  [ [ [0,1],[1,0],[0,-1],[-1,0] ], 1 ],
);

is( is_square(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub is_square {
  my @pts = @_;

  ## If we measure the squared distances between each
  ## pari of points of a square we get two distances -
  ## the edge and diagonal.
  ## The latter being twice the former...
  ##
  ## No other combination of points has this property.

  ## Compute distances...
  my %D;
  while(@pts>1) {
    my $a = shift @pts;
    $D{($a->[0]-$_->[0])**2+($a->[1]-$_->[1])**2}++ foreach @pts;
  }
  my %F = reverse %D;
  return exists $F{2} && exists $F{4} && $F{2} == 2*$F{4} || 0;
}

