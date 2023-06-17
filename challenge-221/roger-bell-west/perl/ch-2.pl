#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(arithmeticsubsequence([9, 4, 7, 2, 10]), 3, 'example 1');
is(arithmeticsubsequence([3, 6, 9, 12]), 4, 'example 2');
is(arithmeticsubsequence([20, 1, 15, 3, 10, 5, 8]), 4, 'example 3');

sub isas($a) {
  my $t = $a->[1] - $a->[0];
  foreach my $i (2..$#{$a}) {
    if ($a->[$i] - $a->[$i-1] != $t) {
      return 0;
    }
  }
  return 1;
}

sub arithmeticsubsequence($ints) {
  my @stack = ($ints);
  while (scalar @stack > 0) {
    my $t = shift @stack;
    if (isas($t)) {
      return scalar @{$t};
    } else {
      foreach my $i (0..$#{$t}) {
        my @tt;
        foreach my $ix (0..$#{$t}) {
          if ($i != $ix) {
            push @tt, $t->[$ix];
          }
        }
        push @stack, \@tt;
      }
    }
  }
  return 0;
}
