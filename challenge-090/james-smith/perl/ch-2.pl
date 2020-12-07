#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

## This is ripe for bit operators - as it is about multiplying/diving by 2...
## and checking for the value of the "1s" bit....

foreach(1..10) {
  my $x = int rand(40);
  my $y = int rand(40);
  is( eth_mult( $x , $y ), $x*$y );
}

done_testing();

sub eth_mult {
  my( $n, $m ) = @_;
  my $res = 0;
  while($n) {
    $res += $m if $n&1;
    $m<<=1;
    $n>>=1;
  }
  return $res;
}

