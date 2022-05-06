#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(summation([1,2,3,4,5]),42,'example 1');
is(summation([1,3,5,7,9]),70,'example 2');

use List::Util qw(reduce);

sub summation {
  my $ls = shift;
  while (scalar @{$ls} > 1) {
    my @lv;
    foreach my $i (1..$#{$ls}) {
      push @lv,reduce {$a + $b} (0,map {$ls->[$_]} (1..$i));
    }
    $ls = \@lv;
  }
  return $ls->[0];
}
