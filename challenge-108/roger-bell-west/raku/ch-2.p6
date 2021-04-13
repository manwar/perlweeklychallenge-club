#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(bell(10),[1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147],'example 1');

sub bell($count) {
  my @a;
  push @a,[1];
  for 1..$count-1 -> $row {
    my @b=@a[*-1][*-1];
    for 1..$row -> $col {
      push @b,@b[$col-1]+@a[*-1][$col-1];
    }
    push @a,@b;
  }
  return [map {$_[0]},@a];
}
