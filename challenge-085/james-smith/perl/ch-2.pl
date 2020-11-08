#!/usr/local/bin/perl

use strict;
use warnings;
use Test::More;

is( is_power(1),        1);
is( is_power(8),        1);
is( is_power(15),       0);
is( is_power(125),      1);
is( is_power(21943**3), 1);
is( is_power(4294967295),    0);
is( is_power(2**60),    1);
is( is_power(225),      1);

done_testing;

sub is_power {
  ## Avoid using powers as this is inefficient...
  my $n = shift;
  return 1 if $n == 1;    ## This is an edge case!
  for(my $i=2;1;$i++) {
    my $s = $i*$i;
    last if $s>$n;
    for($_=0;1;$_++) {
      return 1 if $s == $n;
      last if $n%$s;
      $s*=$i;
    }
  }
  return 0;
}
