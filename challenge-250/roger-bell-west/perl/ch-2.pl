#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(alphanumericstringvalue(['perl', 2, 000, 'python', 'raku']), 6, 'example 1');
is(alphanumericstringvalue([001, 1, 000, 0001]), 1, 'example 2');

use List::Util qw(max);

sub alphanumericstringvalue($a) {
  my @l;
  foreach my $n (@{$a}) {
    if ($n =~ /^[0-9]+$/) {
      push @l, 0 + $n;
    } else {
      push @l, length($n);
    }
  }
  return max(@l);
}
