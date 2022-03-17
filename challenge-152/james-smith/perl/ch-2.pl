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
  my ($l,$b,$r,$t,$L,$B,$R,$T) = map { @{$_} } @_;
  my $w3 = (my $w1=$r-$l)+(my $w2=$R-$L)+($l<$L?$l:$L)-($r<$R?$R:$r);
  my $h3 = (my $h1=$t-$b)+(my $h2=$T-$B)+($b<$B?$b:$B)-($t<$T?$T:$t);
  $w1*$h1 + $w2*$h2 - ($w3>0 && $h3>0 && $w3*$h3);
}

