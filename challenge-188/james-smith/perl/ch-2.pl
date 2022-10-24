#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 5, 4, 5 ],
  [ 4, 6, 3 ],
  [ 2, 5, 4 ],
  [ 3, 1, 3 ],
  [ 5, 4, 5 ],
  [ 130504, 510, 276 ],
);

is( total_zero( $_->[0], $_->[1] ), $_->[2] ) for @TESTS;
is( total_lh(   $_->[0], $_->[1] ), $_->[2] ) for @TESTS;

done_testing();

cmpthese( 500_000, {
  'tz' => sub { total_zero( $_->[0], $_->[1] ) for @TESTS },
  'tl' => sub { total_lh(   $_->[0], $_->[1] ) for @TESTS },
});

sub total_zero {
  my($t,$x,$y) = (0,@_);

  ## We could just do the steps one at a time - but note
  ## that we can repeat one of the steps multiple times
  ## if $a >= $n.$b we can repeat the $a - $b $n times
  ## before we have to swap $a & $b over...

  ($t,$x,$y) = $x > $y ? ($t+int($x/$y),$y,$x%$y) : ($t+int($y/$x),$x,$y%$x) while $x&&$y;

  $t;
}

sub total_lh {
  my($t,$x,$y) = (0,@_);
  ($t,$x,$y) = $x > $y ? ($t+1,$y,$x-$y) : ($t+1,$x,$y-$x) while $x&&$y;
  $t;
}
