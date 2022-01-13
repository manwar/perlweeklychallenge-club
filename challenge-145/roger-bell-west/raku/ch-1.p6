#! /usr/bin/perl6

use Test;
plan 1;

is(dotproduct((1,2,3),(4,5,6)),32,'example 1');

sub dotproduct(@a,@b) {
  my $p=0;
  for 0..@a.end -> $i {
    $p += @a[$i]*@b[$i];
  }
  return $p;
}
