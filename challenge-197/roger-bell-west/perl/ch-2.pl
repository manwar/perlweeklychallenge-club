#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 8;

is(is_wigglesorted([1,5,1,1,6,4]), 0, 'example 1');
is(is_wigglesorted([1,6,1,5,1,4]), 1, 'example 2');
is(is_wigglesorted([1,3,2,2,3,1]), 0, 'example 3');
is(is_wigglesorted([2,3,1,3,1,2]), 1, 'example 4');
is(is_wigglesorted([1,3,2,2,3,1]), 0, 'example 5');
is(is_wigglesorted(wigglesort([1,5,1,1,6,4])), 1, 'example 6');
is(is_wigglesorted(wigglesort([1,3,2,2,3,1])), 1, 'example 7');
is(is_wigglesorted(wigglesort([1,3,2,2,2,3,1])), 1, 'example 8');

sub is_wigglesorted($l) {
  foreach my $i (0..scalar @{$l}-2) {
    if ($i % 2 == 0) {
      if ($l->[$i] >= $l->[$i+1]) {
        return 0;
      }
    } else {
      if ($l->[$i] <= $l->[$i+1]) {
        return 0;
      }
    }
  }
  return 1;
}

sub wigglesort($l) {
  my @s = sort @{$l};
  my $le = scalar @s;
  my $p = int($le / 2);
  my @a = @s[0 .. $p - 1];
  my @b = @s[$p .. $#s];
  my $i = 0;
  my @o;
  if ($le % 2 == 1) {
    push @o,$s[$p];
    @b = @s[$p + 1 .. $#s];
    $i = 1;
  }
  foreach my $j ($i .. $#s) {
    if ($j % 2 == 0) {
      push @o, pop @a;
    } else {
      push @o, pop @b;
    }
  }
  return \@o;
}
