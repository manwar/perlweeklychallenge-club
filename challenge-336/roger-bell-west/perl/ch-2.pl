#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(finalscore(['5', '2', 'C', 'D', '+']), 30, 'example 1');
is(finalscore(['5', '-2', '4', 'C', 'D', '9', '+', '+']), 27, 'example 2');
is(finalscore(['7', 'D', 'D', 'C', '+', '3']), 45, 'example 3');
is(finalscore(['-5', '-10', '+', 'D', 'C', '+']), -55, 'example 4');
is(finalscore(['3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+']), 128, 'example 5');

use List::Util qw(sum);

sub finalscore($a) {
  my @p;
  foreach my $n (@{$a}) {
    if ($n eq 'C') {
      pop @p;
    } elsif ($n eq 'D') {
      push @p, $p[-1] * 2;
    } elsif ($n eq '+') {
      push @p, $p[-2] + $p[-1];
    } else {
      push @p, 0 + $n;
    }
  }
  sum @p;
}
