#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [1,0,0]   =>  1 ],
  [ [1,1,1,0] =>  0 ],
  [ [1,1,1]   => -1 ],
);

sub special_bit_chars {
  return -1 if $_[-1];
  ($_[0]&&shift),shift until @_<2;
  scalar @_
}

sub special_bit_chars_reverse {
  my$f,pop?return-1:pop||return 1;
  $f=!$f,pop||last while@_;
  ~~$f
}
