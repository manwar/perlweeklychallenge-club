#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(jortsort([1,2,3,4,5]),1,'example 1');
is(jortsort([1,3,2,4,5]),0,'example 2');

sub jortsort {
  my $a=shift;
  foreach my $i (1..$#{$a}) {
    if ($a->[$i-1] > $a->[$i]) {
      return 0;
    }
  }
  return 1;
}
