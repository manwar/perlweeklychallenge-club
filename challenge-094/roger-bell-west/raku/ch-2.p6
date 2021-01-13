#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(bt2ll(1,2,3,4,5,-1,-1,-1,-1,6,7),
          (1,2,4,5,6,7,3),
          'example 1',
            );

sub bt2ll(**@tree) {
  return recurse(@tree,0);
}

sub recurse(@tree,$start) {
  my @out=(@tree[$start]);
  my $b=$start*2+1;
  for ($b,$b+1) -> $ba {
    if ($ba <= @tree.end && @tree[$ba]>=0) {
      for recurse(@tree,$ba) -> $t {
        push @out,$t;
      }
    }
  }
  return @out.flat;
}

