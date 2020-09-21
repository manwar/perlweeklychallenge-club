#! /usr/bin/perl6

use Test;

plan 2;

is(csb(4),5,'example 1');
is(csb(3),4,'example 2');

sub csb($tot) {
  my $bits=0;
  my $m=1000000007;
  for 1..$tot -> $n {
    my $k=$n;
    while ($k > 0) {
      $bits += $k +& 1;
      $k +>= 1;
    }
    $bits %= $m;
  }
  return $bits;
}
