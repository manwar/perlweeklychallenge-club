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
  my @K = keys %D;
  return 0 unless @K== 2;      ## More than two distances
  return 1 if $K[0]*2==$K[1];  ## First no is the diagonal
  return 1 if $K[1]*2==$K[0];  ## First no is the edge..
  return 0;                    ## Equilat triangles..
}

