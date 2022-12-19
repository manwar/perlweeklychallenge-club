#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [3,1,4,2],     '3 4 2' ],
  [ [1,2,3,4],     '' ],
  [ [1,3,2,4,6,5], '1 3 2' ],
  [ [1,3,2],       '1 3 2' ] );

is( "@{[ pattern132( @{$_->[0]} ) ]}", $_->[1] ) for @TESTS;
done_testing();

sub pattern132 {
  while(my$x=shift@_){
    for my $i (0..$#_-1) {
      next if $x > $_[$i];
      ($x<$_)&&($_<=$_[$i])&&return $x,$_[$i],$_ for @_[$i+1..$#_]
    }
  }
  ()
}
