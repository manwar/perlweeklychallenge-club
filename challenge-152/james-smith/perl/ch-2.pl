#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [ [ -1,  0], [  2,  2], [  0, -1], [  4,  4] ], 22 ],
  [ [ [ -3, -1], [  1,  3], [ -1, -3], [  2,  2] ], 25 ],
  [ [ [-10,-10], [ -8, -8], [  8,  8], [ 10, 10] ],  8 ],
  [ [ [ -1, -1], [  1,  1], [ -1, -1], [  1,  1] ],  4 ],
);

is( my_area(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub my_area {
  my ($l,$r,$L,$R) = @_;
  my $w3 = (my $w1 = $r->[0]-$l->[0]) + (my $w2 = $R->[0]-$L->[0]) + ($l->[0]<$L->[0]?$l->[0]:$L->[0]) - ($r->[0]>$R->[0]?$r->[0]:$R->[0]);
  my $h3 = (my $h1 = $r->[1]-$l->[1]) + (my $h2 = $R->[1]-$L->[1]) + ($l->[1]<$L->[1]?$l->[1]:$L->[1]) - ($r->[1]>$R->[1]?$r->[1]:$R->[1]);
  $w1*$h1 + $w2*$h2 - ($w3>0 && $h3>0 && $w3*$h3);
}

