#!/usr/local/bin/perl

use strict;
use warnings;
use Test::More;

is( is_power(8),   1);
is( is_power(15),  0);
is( is_power(125), 1);

done_testing;

sub is_power {
  my $n = shift;
  for(my $i=2;1;$i++) {
    last if 2**$i>$n;
    for($_=1;1;$_++) {
      return 1 if $n == $_**$i;
      last if $_**$i>$n;
    }
  }
  return 0;
}
