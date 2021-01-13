#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(msw((1,5,0,2,9,3,7,6,4,8),3),
          (0,0,0,2,3,3,4,4),
          'example',
            );

sub msw(@a,$s) {
  my @out;
  for (0..(@a.elems-$s)) -> $i {
    push @out,min(@a[$i..$i+$s-1]);
  }
  return @out.flat;
}
