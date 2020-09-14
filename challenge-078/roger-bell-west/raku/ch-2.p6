#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(leftrot((10, 20, 30, 40, 50),(3, 4)),
          [[40, 50, 10, 20, 30],
           [50, 10, 20, 30, 40]],
          'example 1');
is-deeply(leftrot((7, 4, 2, 6, 3),(1, 3, 4)),
          [[4, 2, 6, 3, 7],
           [6, 3, 7, 4, 2],
           [3, 7, 4, 2, 6]],
          'example 2');

sub leftrot(@a,@b) {
  my $l=@a.end;
  my @t=(@a,@a).flat;
  my @o;
  for @b -> $c {
    push @o,[@t[$c..$c+$l]];
  }
  return @o;
}
