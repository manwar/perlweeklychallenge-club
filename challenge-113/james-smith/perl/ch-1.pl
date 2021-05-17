#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese);

my @ex = ( [25,8,0], [25,7,0], [24,7,1], [24,0,0], [10,0,1], [28,8,1], [26,8,1], [16,8,0], [441,9,1], [431,9,0] );

is( represent( $_->[0], $_->[1]), $_->[2] ) foreach @ex;

done_testing();

sub represent {
  my($t,$n,$d) = (0,@_);
  1+($t+=$_*10+$d) && $n>=$t && ($n%10 == $t%10) && return 1 for 0..9;
  return 0;
}

