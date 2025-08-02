#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(thirtythreepercentappearance([1, 2, 3, 3, 3, 4, 2]), 3, 'example 1');
is(thirtythreepercentappearance([1, 1]), 1, 'example 2');
is(thirtythreepercentappearance([1, 2, 3]), 1, 'example 3');

use List::Util qw(min);

sub thirtythreepercentappearance($a) {
  my %c;
  foreach my $n (@{$a}) {
    $c{$n}++;
  }
  my $threshold=int((scalar @{$a}) * 33 / 100);
  if (($threshold * 100 / 33) != scalar @{$a}) {
    $threshold++;
  }
  my @s = grep {$c{$_} >= $threshold} keys %c;
  if (@s) {
    return min(@s);
  } else {
    return undef;
  }
}
