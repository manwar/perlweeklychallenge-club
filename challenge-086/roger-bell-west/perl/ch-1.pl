#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(pd([10, 8, 12, 15, 5],7),1,'example 1');
is(pd([1, 5, 2, 9, 7],6),1,'example 2');
is(pd([10, 30, 20, 50, 40],15),0,'example 3');

sub pd {
  my $n=shift;
  my $a=shift;
  my %n=map {$_ => 1} @{$n};
  foreach my $p (map {$_+$a} keys %n) {
    if (exists $n{$p}) {
      return 1;
    }
  }
  return 0;
}
